//
//  EditDiaryViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/07.
//

import UIKit
import YPImagePicker

class EditDiaryViewController: UIViewController  {
    var pickedImg: [UIImage] = []
    var colors: [Colors]?
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

}

extension EditDiaryViewController: EditBtnDelegate, AddPhotoDelegate, AddPhotoInEmptyDelegate, RecordDelegate{
    func presentRecordVC() {
        let sb = UIStoryboard(name: "Audio", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "AudioBackgroundViewController") as? AudioBackgroundViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = .black.withAlphaComponent(0.4)
        self.present(vc, animated: true, completion: nil)
    }
    
    func addPhoto() {
        addPost()
    }
    
    func addPhotoInEmpty() {
        addPost()
    }
    
    func dismissEditDiary() {
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
                cell.photos = pickedImg
                cell.photoCollectionview.reloadData()
                return cell
            }
            
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioTableViewCell", for: indexPath) as? AudioTableViewCell else {return UITableViewCell()}
            cell.recordPresentDelegate = self
        
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditBtnTableViewCell", for: indexPath) as? EditBtnTableViewCell else {return UITableViewCell()}
        
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
            return 169
       
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
        config.library.maxNumberOfItems = 4
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
    
}
