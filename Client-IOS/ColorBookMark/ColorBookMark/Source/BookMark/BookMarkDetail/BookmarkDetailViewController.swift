//
//  BookmarkDetailViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/19.
//

import UIKit

class BookmarkDetailViewController: UIViewController {
    @IBOutlet weak var dayView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    var diaryId: Int?
    var modifyMode: Bool?
    var bookmarkDetail: Diary?
    lazy var bookmarkDetilDataManager: BookMarkDetailDataManager = BookMarkDetailDataManager()

    @IBAction func backBtnTapped(_ sender: Any) {
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
        
        tableview.register(UINib(nibName: "ModifyStoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ModifyStoryTableViewCell")
        tableview.register(UINib(nibName: "ModifyImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ModifyImageCellTableViewCell")
        tableview.register(UINib(nibName: "ModifyRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "ModifyRecordTableViewCell")
        
        tableview.register(UINib(nibName: "ButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonsTableViewCell")
        tableview.register(UINib(nibName: "ModifyButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "ModifyButtonsTableViewCell")
        bookmarkDetilDataManager.getBookMarkDetail(diaryId: diaryId ?? 0, delegate: self)
        dayView.layer.cornerRadius = 8

       
    }
    

}


extension BookmarkDetailViewController: ModifyModeDelegate{
    func doneModifytMode() {
        modifyMode = false
        tableview.reloadData()
    }
    
    func changeModifyMode() {
        modifyMode = true
        tableview.reloadData()
    }
    
    
}


extension BookmarkDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 2))
        view.backgroundColor = .clear

        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderInfoTableViewCell", for: indexPath) as? HeaderInfoTableViewCell else {return UITableViewCell()}
            cell.nickNameLabel.text = "오늘 \(Constant.nickname ?? "")님의 색갈피는"
            cell.colorLabel.text = "\(bookmarkDetail?.diary?.diaryContents?.colorName ?? "")의 색"
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            
            return cell
        case 1:
            if !(modifyMode ?? false) {
            
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else {return UITableViewCell()}
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyStoryTableViewCell", for: indexPath) as? ModifyStoryTableViewCell else {return UITableViewCell()}
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                return cell
            }
           
            
        case 2:
            if !(modifyMode ?? false){
            
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesTableViewCell", for: indexPath) as? ImagesTableViewCell else {return UITableViewCell()}
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyImageCellTableViewCell", for: indexPath) as? ModifyImageCellTableViewCell else {return UITableViewCell()}
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                return cell
            }
           
            
        case 3:
            if !(modifyMode ?? false){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell else {return UITableViewCell()}
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyRecordTableViewCell", for: indexPath) as? ModifyRecordTableViewCell else {return UITableViewCell()}
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                return cell
            }
           
           
            
        case 4:
            if !(modifyMode ?? false){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonsTableViewCell", for: indexPath) as? ButtonsTableViewCell else {return UITableViewCell()}
                cell.modifyDelegate = self
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyButtonsTableViewCell", for: indexPath) as? ModifyButtonsTableViewCell else {return UITableViewCell()}
                cell.doneDelegate = self
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                return cell
            }
           
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 163
        case 2:
            return 144
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
        bookmarkDetail = result.result
        setDetailBackgroundColors()
        tableview.reloadData()
        
       
        
    }
    
    func failedToGetBookMarkDetail(message: String) {
        print("------>>>>\(message)")
        
    }
    
    func setDetailBackgroundColors() {
        
        let colors: [CGColor] = [
            hexStringToUIColor(hex:"#FFFFFF").cgColor,
            hexStringToUIColor(hex:bookmarkDetail?.diary?.diaryContents?.color ?? "#ffffff").cgColor,
                                  ]
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame  = self.view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
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
