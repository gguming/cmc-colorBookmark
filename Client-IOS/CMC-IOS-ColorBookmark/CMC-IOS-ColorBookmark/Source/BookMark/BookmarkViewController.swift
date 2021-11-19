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
    }
    
    @IBAction func monthBtnTapped(_ sender: Any) {
    }
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
 

}

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as? BookmarkTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    
}
