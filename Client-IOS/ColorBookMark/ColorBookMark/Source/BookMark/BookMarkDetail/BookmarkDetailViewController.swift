//
//  BookmarkDetailViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/19.
//

import UIKit
import Alamofire

class BookmarkDetailViewController: UIViewController {
    @IBOutlet weak var dayView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    var date: String?
    var diaryId: Int?
    var modifyMode: Bool?
    
    let modifyDetailInfo = ModifyDetailInfo.shared
    var bookmarkDetail: Diary?
    var pickedImg: [UIImage]?
    var addedImg: [String] = []
    var index: Int?
    
    var delegateDeleteDiaryinList: DelegateDeleteDiary?
    lazy var bookmarkModifyDataManager: BookMarkModifyDataManager = BookMarkModifyDataManager()
    lazy var bookmarkDetilDataManager: BookMarkDetailDataManager = BookMarkDetailDataManager()
    lazy var deleteDiaryDataManager: BookMakrDetailDeleteDataManager = BookMakrDetailDeleteDataManager()
    @IBAction func backBtnTapped(_ sender: Any) {
        let modifyDetailInfo = ModifyDetailInfo.shared
        modifyDetailInfo.text = ""
        modifyDetailInfo.addImg = []
        modifyDetailInfo.record = ""
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyMode = false
        tableview.backgroundColor = .clear
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.register(UINib(nibName: "HeaderInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderInfoTableViewCell")
        tableview.register(UINib(nibName: "StoryTableViewCell", bundle: nil), forCellReuseIdentifier: "StoryTableViewCell")
        tableview.register(UINib(nibName: "ImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "ImagesTableViewCell")
        tableview.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordTableViewCell")
        
        tableview.register(UINib(nibName: "StoryHaveTableViewCell", bundle: nil), forCellReuseIdentifier: "StoryHaveTableViewCell")
        tableview.register(UINib(nibName: "ImageHaveTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageHaveTableViewCell")
        tableview.register(UINib(nibName: "RecordHaveTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordHaveTableViewCell")
        
        
        tableview.register(UINib(nibName: "ButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonsTableViewCell")
        tableview.register(UINib(nibName: "ModifyButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "ModifyButtonsTableViewCell")
        hideKeyboard()
        dayView.layer.cornerRadius = 8
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        bookmarkDetilDataManager.getBookMarkDetail(diaryId: diaryId ?? 0, delegate: self)
    }
    
    func hideKeyboard()
        {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(BookmarkDetailViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard()
        {
            view.endEditing(true)
        }
    
    
    private func modifyDiary() {
        let modifyDetailInfo = ModifyDetailInfo.shared
        var request = ModifyRequest()
        request.colorName = bookmarkDetail?.diary?.diaryContents?.colorName
        request.color = bookmarkDetail?.diary?.diaryContents?.color
        request.date = date
        if modifyDetailInfo.text == nil {
            request.content = "iplagkeas"
        } else {
            request.content = modifyDetailInfo.text
        }
        //
        let count = modifyDetailInfo.addImg?.count ?? 0
        if count == 0 {
            request.diaryImgUrl = []
        } else {
            
            for i in 0..<count {
                let url = modifyDetailInfo.addImg?[i].diaryImgUrl ?? ""
                print(url)
                self.addedImg.append(url)
                print(i)
            }
            request.diaryImgUrl = addedImg
        }
        
        if modifyDetailInfo.record == nil {
            request.recordContent = "iplagkeas"
        }
        
        bookmarkModifyDataManager.diaryModify(request, delegate: self)
        
        
        
        
    }
    
    
}


extension BookmarkDetailViewController: ModifyModeDelegate, DeleteModifyImg, DeleteRecordDelegate, PresentImgDetailVC{
    func presentImgDetailVC() {
        
        print(11111111)
        let vc = ImageDetailViewController()
        vc.addImg = modifyDetailInfo.addImg
        present(vc, animated: true)
    }
    
    func deleteRecord() {
        let modifyInfo = ModifyDetailInfo.shared
        modifyInfo.record = nil
        tableview.reloadData()
    }
    
    
    func deleteModifyImg(index: Int) {
        let modifyInfo = ModifyDetailInfo.shared
        modifyInfo.addImg?.remove(at: index)
        tableview.reloadData()
    }
    
    func deleteDiary() {
        let alert = UIAlertController(title: "다이어리를 삭제하시겠습니까?", message: "삭제하게 되면 복구할 수 없습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "승인", style: .default) { _ in
            let request = DeleteDiaryRequest()
            request.date = self.date
            self.deleteDiaryDataManager.diaryDelete(request: request , delegate: self)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func doneModifytMode() {
        
        let alert = UIAlertController(title: "다이어리를 수정하시겠습니까?", message: "수정하게 되면 복구할 수 없습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "승인", style: .default) { _ in
            self.modifyMode = false
            self.modifyDiary()
            self.tableview.reloadData()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func changeModifyMode() {
        modifyMode = true
        tableview.reloadData()
    }
    
    
}


extension BookmarkDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let modifyDetailInfo = ModifyDetailInfo.shared
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderInfoTableViewCell", for: indexPath) as? HeaderInfoTableViewCell else {return UITableViewCell()}
            cell.nickNameLabel.text = "오늘 \(Constant.nickname ?? "")님의 색갈피는"
            cell.colorLabel.text = "\(bookmarkDetail?.diary?.diaryContents?.colorName ?? "")의 색"
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            
            return cell
        case 1:
            if !(modifyMode ?? false) {
                if modifyDetailInfo.text == nil {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else {return UITableViewCell()}
                    cell.layer.cornerRadius = 8
                    
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryHaveTableViewCell", for: indexPath) as? StoryHaveTableViewCell else {return UITableViewCell()}
                    
                    cell.textView.isEditable = false
                    cell.textView.text = modifyDetailInfo.text
                    return cell
                }
                
            } else {
                
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryHaveTableViewCell", for: indexPath) as? StoryHaveTableViewCell else {return UITableViewCell()}
                cell.textView.isEditable = true
                
                cell.textView.text = modifyDetailInfo.text
                return cell
                
                
                
            }
            
            
        case 2:
            if !(modifyMode ?? false){
                if (modifyDetailInfo.addImg?.count == 0) {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesTableViewCell", for: indexPath) as? ImagesTableViewCell else {return UITableViewCell()}
                   
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageHaveTableViewCell", for: indexPath) as? ImageHaveTableViewCell else {return UITableViewCell()}
                    cell.addImg = modifyDetailInfo.addImg
                    cell.presentDelegate = self
                    cell.delegateForDelete = self
                    cell.modifyMode = false
                    cell.imgHaveCollectionview.reloadData()
                    
                    
                    return cell
                }
            } else {
                if (modifyDetailInfo.addImg?.count == 0) {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesTableViewCell", for: indexPath) as? ImagesTableViewCell else {return UITableViewCell()}
                   
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageHaveTableViewCell", for: indexPath) as? ImageHaveTableViewCell else {return UITableViewCell()}
                    cell.addImg = modifyDetailInfo.addImg
                    cell.presentDelegate = self
                    cell.delegateForDelete = self
                    cell.modifyMode = true
                    cell.imgHaveCollectionview.reloadData()
                    
                    
                    return cell
                }
            }
            
            
        case 3:
            if !(modifyMode ?? false){
                
                if modifyDetailInfo.record == nil {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell else {return UITableViewCell()}
                    
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordHaveTableViewCell", for: indexPath) as? RecordHaveTableViewCell else {return UITableViewCell()}
                    cell.record = modifyDetailInfo.record
                    cell.deleteBtn.isHidden = true
                    cell.deleteDelegate = self
                    return cell

                }
            } else {
                if modifyDetailInfo.record == nil {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell else {return UITableViewCell()}
                    
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordHaveTableViewCell", for: indexPath) as? RecordHaveTableViewCell else {return UITableViewCell()}
                    cell.record = modifyDetailInfo.record
                    cell.deleteDelegate = self
                    cell.deleteBtn.isHidden = false
                    return cell

                }
            }
            
            
            
        case 4:
            if !(modifyMode ?? false){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonsTableViewCell", for: indexPath) as? ButtonsTableViewCell else {return UITableViewCell()}
                cell.modifyDelegate = self
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyButtonsTableViewCell", for: indexPath) as? ModifyButtonsTableViewCell else {return UITableViewCell()}
                cell.doneDelegate = self
                
                return cell
            }
            
        default:
            return UITableViewCell()
        }
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 163
        case 2:
            return 180
        case 3:
            return 127
        case 4:
            return 40
        default:
            return 0
        }
    }
    
    
}


extension BookmarkDetailViewController {
    func didSuccessGetBookMarkDetail(_ result: GetBookMarkDetailResponse) {
        print("------>\(result)")
        let modifyDetailInfo = ModifyDetailInfo.shared
        bookmarkDetail = result.result
        modifyDetailInfo.text = result.result?.diary?.diaryContents?.content
        modifyDetailInfo.addImg = result.result?.diary?.diaryImage
        modifyDetailInfo.record = result.result?.diary?.diaryContents?.recordContent
        setDetailBackgroundColors()
        tableview.reloadData()
        
        
        
    }
    
    func failedToGetBookMarkDetail(message: String) {
        print("------>>>>\(message)")
        presentBottomAlert(message: message)
        
    }
    
    func didSuccessModifyDetail(_ result: ModifyResponse) {
        print("------>\(result)")
        addedImg = []
        presentBottomAlert(message: result.message)
        
        
        
    }
    
    func failedToModifyDetail(message: String) {
        print("------>>>>\(message)")
        presentBottomAlert(message: message)
        
    }
    
    func didSuccessDelete(_ result: DeleteDiaryResponse) {
        print("------>\(result)")
        
        
        let alert = UIAlertController(title: "다이어리가 삭제되었습니다.", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: false, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)  
        
    }
    
    func failedToDelete(message: String) {
        print("------>>>>\(message)")
        presentBottomAlert(message: message)
        
    }
    
    func setDetailBackgroundColors() {
        let customDate = bookmarkDetail?.diary?.diaryContents?.date?.components(separatedBy: "-")
        dateLabel.text = "\(customDate?[0] ?? "2021").\(customDate?[1] ?? "12").\(customDate?[2] ??  "1")"
        
        let colors: [CGColor] = [
            hexStringToUIColor(hex:"#FFFFFF").cgColor,
            hexStringToUIColor(hex:bookmarkDetail?.diary?.diaryContents?.color ?? "#ffffff").cgColor,
        ]
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame  = self.view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let layer = CALayer()
        layer.frame = self.view.bounds
        layer.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor
        self.view.layer.insertSublayer(layer, at: 1)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

protocol DelegateDeleteDiary {
    func deleteDiaryinList(index: Int, message: String)
}
