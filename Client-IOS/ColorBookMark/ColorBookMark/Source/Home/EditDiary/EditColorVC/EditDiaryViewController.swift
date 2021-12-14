//
//  EditDiaryViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/07.
//

import UIKit
import YPImagePicker
import FirebaseStorage

class EditDiaryViewController: UIViewController  {
    var recordUrl: String?
    var pickedImg: [UIImage] = []
    var imgUrls: [String] = []
    var colors: [Colors]?
    let storage = Storage.storage().reference()
    
    lazy var postDataManager: PostDiaryDataManager = PostDiaryDataManager()
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 셀 등록
        tableview.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableview.register(UINib(nibName: "ColorTableViewCell", bundle: nil), forCellReuseIdentifier: "ColorTableViewCell")
        tableview.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        tableview.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        tableview.register(UINib(nibName: "PhotoHaveTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoHaveTableViewCell")
        tableview.register(UINib(nibName: "AudioTableViewCell", bundle: nil), forCellReuseIdentifier: "AudioTableViewCell")
        tableview.register(UINib(nibName: "AudioHaveTableViewCell", bundle: nil), forCellReuseIdentifier: "AudioHaveTableViewCell")
        tableview.register(UINib(nibName: "EditBtnTableViewCell", bundle: nil), forCellReuseIdentifier: "EditBtnTableViewCell")
        
        tableview.dataSource = self
        tableview.delegate = self
        
        
    }
    
    func uploadDiary() {
        showIndicator()
        let uuid = UUID().uuidString
        let recordInfo = RecordInfo.shared
        let colorInfo = ColorPickerInfo.shared
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: Date())
        var count = 0
        var request = PostDiaryRequest()
        request.date = currentDate
        request.content = recordInfo.text
        if colorInfo.color == nil {
            presentBottomAlert(message: "색깔을 골라주세요!")
            return
        }
        request.color = colorInfo.color
        request.colorName = colorInfo.colorName
        print("시작시작시작시작시작")
        if !pickedImg.isEmpty {
                
            for img in 0..<pickedImg.count{
                guard let image = pickedImg[img].pngData() else {return}
                storage.child("images/\(uuid)/\(img).png").putData(image,
                                                              metadata: nil){ _, error in
                    guard error == nil else {
                        print("Failed to upload")
                        return
                    }
                    self.storage.child("images/\(uuid)/\(img).png").downloadURL { url, error in
                        guard let url = url, error == nil else {
                            return
                        }
                        
                        let urlString = url.absoluteString
                        self.imgUrls.append(urlString)
                        print("-------> URL : \(urlString)")
                        count += 1
                        
                        
                        if count == self.pickedImg.count{
                            if recordInfo.recordURL != nil {
                                guard let record = recordInfo.recordURL else {return}
                                self.storage.child("record/\(uuid)/\(record).m4a").putFile(from: record, metadata: nil) { metadata, error in
                                    if error != nil {
                                        print(error ?? "error")
                                    }

                                    self.storage.child("record/\(uuid)/\(record).m4a").downloadURL(completion: { url, error in
                                        guard let url = url, error == nil else {
                                            return
                                        }
                                        let urlString = url.absoluteString
                                        self.recordUrl = urlString
                                        print("------->record URL : \(urlString)")
                                        request.diaryImgUrl = self.imgUrls
                                        request.recordContent = urlString
                                        
                                        self.postDataManager.diaryPost(request, delegate: self)
                                        self.dismissIndicator()
                                        
                                    })
                                }
                            } else {
                                request.diaryImgUrl = self.imgUrls
                                self.postDataManager.diaryPost(request, delegate: self)
                                self.dismissIndicator()
                            }
                        }
                    }
                }
                
            }
        
        } else {
            if recordInfo.recordURL != nil {
                guard let record = recordInfo.recordURL else {return}
                storage.child("record/\(uuid)/\(record).m4a").putFile(from: record, metadata: nil) { metadata, error in
                    if error != nil {
                        print(error ?? "error")
                    }

                    self.storage.child("record/\(uuid)/\(record).m4a").downloadURL(completion: { url, error in
                        guard let url = url, error == nil else {
                            return
                        }
                        let urlString = url.absoluteString
                        self.recordUrl = urlString
                        print("------->record URL : \(urlString)")
                        request.recordContent = urlString
                        self.postDataManager.diaryPost(request, delegate: self)
                        self.dismissIndicator()
                        
                    })
                }
            } else {
                self.postDataManager.diaryPost(request, delegate: self)
                self.dismissIndicator()
            }
        }
        
        
        
        print("끝끝끝끝끝")
        
    }
    
//    private func currentMonth()

}

extension EditDiaryViewController: EditBtnDelegate, AddPhotoDelegate, AddPhotoInEmptyDelegate, RecordDelegate, recordSaveDelegate, DeleteRecordDelegate, AddDiaryDelegate, DeletePhotoDelegate{
    func deletePhoto(index: Int) {
        pickedImg.remove(at: index)
        tableview.reloadData()
    }
    
    func addDiary() {
        
        let alert = UIAlertController(title: "색갈피를 등록하시겠습니까?", message: "승인을 누르시면 등록됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "승인", style: .default) { _ in
            self.uploadDiary()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func deleteRecord() {
        let recordInfo = RecordInfo.shared
        recordInfo.recordURL = nil
        self.tableview.reloadData()
    }
    
    func recordSave() {
        self.tableview.reloadData()
    }
    
   
    
    func presentRecordVC() {
        let sb = UIStoryboard(name: "Audio", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "AudioBackgroundViewController") as? AudioBackgroundViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = .black.withAlphaComponent(0.4)
        vc.recordSaveDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func addPhoto() {
        if pickedImg.count == 5 {
            presentBottomAlert(message: "최대 5개 사진을 추가할 수 있습니다.")
        } else {
            addPost()
        }
        
    }
    
    func addPhotoInEmpty() {
        addPost()
    }
    
    func dismissEditDiary() {
        let recordInfo = RecordInfo.shared
        recordInfo.recordURL = nil
        self.dismiss(animated: true, completion: nil)
    }
    
   
}

// MARK: UITableViewDelegate,UITableViewDataSource
extension EditDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as? HeaderTableViewCell else {return UITableViewCell()}

            cell.setUI()
            cell.delegate = self
            return cell
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ColorTableViewCell", for: indexPath) as? ColorTableViewCell else {return UITableViewCell()}
            cell.colors = self.colors
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as? TextTableViewCell else {return UITableViewCell()}
        
            return cell
            
        case 3:
            if pickedImg.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else {return UITableViewCell()}
                cell.delegate = self
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoHaveTableViewCell", for: indexPath) as? PhotoHaveTableViewCell else {return UITableViewCell()}
                cell.delegate = self
                cell.deletePhoto = self
                cell.photos = pickedImg
                cell.photoCollectionview.reloadData()
                return cell
            }
            
            
        case 4:
            let recordInfo = RecordInfo.shared
            if recordInfo.recordURL == nil {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioTableViewCell", for: indexPath) as? AudioTableViewCell else {return UITableViewCell()}
                cell.recordPresentDelegate = self
            
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioHaveTableViewCell", for: indexPath) as? AudioHaveTableViewCell else {return UITableViewCell()}
                cell.deleteRecordDelegate = self
            
                return cell
            }
            
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditBtnTableViewCell", for: indexPath) as? EditBtnTableViewCell else {return UITableViewCell()}
            cell.addDiaryDelegate = self
            return cell
            
        default:
            return UITableViewCell()
        }

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case 0:
            return 80
            
        case 1:
            return 159
       
        case 2:
            return 150
            
        case 3:
            return 150
            
        case 4:
            return 130
            
        case 5:
            return 100
        default:
            return 0
        }
        
    }
}


extension EditDiaryViewController {
    private func addPost() {

        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.showsPhotoFilters = false
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.photo, .library]
        config.showsCrop = .none
        config.wordings.libraryTitle = "사진첩"
        config.wordings.cameraTitle = "카메라"
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.maxCameraZoomFactor = 2.0
        config.library.maxNumberOfItems = 5 - pickedImg.count
        config.gallery.hidesRemoveButton = false
        config.library.skipSelectionsGallery = false
        config.library.defaultMultipleSelection = false

        // imagePicker 설정 code

        let picker = YPImagePicker(configuration: config)
        picker.navigationBar.backgroundColor = .white
        picker.didFinishPicking { [unowned picker] items, cancelled in
            

            if cancelled {
                picker.dismiss(animated: true, completion: nil)
                return
            }
//             여러 이미지를 넣어주기 위해 하나씩 넣어주는 반복문
            for item in items {
                switch item {
                // 이미지만 받기때문에 photo case만 처리
                case .photo(let p):
                    // 이미지를 해당하는 이미지 배열에 넣어주는 code
                    self.pickedImg.append(p.image)
            // original image selected by the user, unfiltered
                    print(p.image)
                default:
                    print("")
                }
            }

            picker.dismiss(animated: true) {
                print(self.pickedImg.count)
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            }
        }
        // picker뷰 present
        present(picker, animated: true, completion: nil)
        
    }
}

// delegate

extension EditDiaryViewController {
    func didSuccessPostDiary(_ result: PostDiaryResponse) {
        print("------>\(result)")
        presentBottomAlert(message: result.message)
       
        
    }
    
    func failedToPostDiary(message: String) {
        print("------>>>>\(message)")
        presentBottomAlert(message: message)
        
    }
}
