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
        monthView.layer.cornerRadius = 8
        monthBtn.titleLabel?.textAlignment = .left
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
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as? BookmarkTableViewCell else {return UITableViewCell()}
            cell.backView.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BookmarkDetailViewController") as? BookmarkDetailViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
}
