//
//  BookmarkViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/19.
//

import UIKit

class BookmarkViewController: UIViewController {
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var monthBtn: UIButton!
    
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
        setUI()
        
        

        
    }
    private func setUI() {
        monthView.layer.cornerRadius = 8
        monthBtn.titleLabel?.textAlignment = .left
        tableview.backgroundColor = .clear
    }
 

}

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as? BookmarkTableViewCell else {return UITableViewCell()}
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BookmarkDetailViewController") as? BookmarkDetailViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    
}
