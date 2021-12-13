//
//  BookmarkViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/19.
//

import UIKit

class BookmarkViewController: BaseViewController {
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var monthBtn: UIButton!
    
    var date: String?
    var bookmarks: [BookMarks]?
    lazy var dataManager: BookMarkDataManager = BookMarkDataManager()
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func monthBtnTapped(_ sender: Any) {
        
    }
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "BookmarkTableViewCell", bundle: nil), forCellReuseIdentifier: "BookmarkTableViewCell")
        tableview.register(UINib(nibName: "BookmarkHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "BookmarkHeaderTableViewCell")
        dataManager.getBookMark(date: date ?? "2021-12", delegate: self)

        
        setUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.getBookMark(date: date ?? "2021-12", delegate: self)
        tableview.reloadData()
        let changeColors: [CGColor] = [
           CGColor(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
           CGColor(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
           CGColor(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        ]
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.toValue = changeColors
        colorAnimation.duration = 10
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = .infinity
        gradientLayer.add(colorAnimation, forKey: "colorChangeAnimation")
        
       
        
        
    }
    private func setUI() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        let currentDate = formatter.string(from: Date())
        monthView.layer.cornerRadius = 8
        monthBtn.titleLabel?.textAlignment = .left
        monthBtn.setTitle(currentDate, for: .normal)
        tableview.backgroundColor = .clear
    }
 

}

extension BookmarkViewController{
    func didSuccessGetBookMakrs(_ result: GetBookMarkResponse) {
        print("------>\(result)")
        bookmarks = result.result
        tableview.reloadData()
       
        
    }
    
    func failedToGetBookMakrs(message: String) {
        print("------>>>>\(message)")
        
    }
    
}

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return bookmarks?.count ?? 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkHeaderTableViewCell", for: indexPath) as? BookmarkHeaderTableViewCell else {return UITableViewCell()}
            cell.buttonUI()
            cell.bookmarkCountInfoLabel.text = "이번달은 총 \(bookmarks?.count ?? 0)번 감정을 끼웠습니다."
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as? BookmarkTableViewCell else {return UITableViewCell()}
            cell.backView.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.contents = bookmarks?[indexPath.row].selectMonthDiary?.diaryContents
            cell.colorView.backgroundColor = hexStringToUIColor22(hex: bookmarks?[indexPath.row].selectMonthDiary?.diaryView?.color ?? "#000000")
            cell.colorLabel.text = bookmarks?[indexPath.row].selectMonthDiary?.diaryView?.colorName
            cell.dayLabel.text = bookmarks?[indexPath.row].selectMonthDiary?.diaryView?.date
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "BookmarkDetailViewController") as? BookmarkDetailViewController else {return}
            vc.modalPresentationStyle = .fullScreen
            print("인덱스패쓰ㅡㅡㅡ")// 0123
            print(indexPath.row)
            print(bookmarks?[indexPath.row].selectMonthDiary?.diaryView?.diaryId)
            vc.diaryId = bookmarks?[indexPath.row].selectMonthDiary?.diaryView?.diaryId
            vc.index = indexPath.row - 1
            self.present(vc, animated: false, completion: nil)
        }
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
}
