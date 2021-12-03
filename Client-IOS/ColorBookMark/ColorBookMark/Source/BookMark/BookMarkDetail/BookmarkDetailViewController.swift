//
//  BookmarkDetailViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/19.
//

import UIKit

class BookmarkDetailViewController: UIViewController {
    @IBOutlet weak var dayView: UIView!
    
    var modifyMode: Bool?
    

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
        
        dayView.layer.cornerRadius = 8

       
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
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = .clear

        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderInfoTableViewCell", for: indexPath) as? HeaderInfoTableViewCell else {return UITableViewCell()}
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else {return UITableViewCell()}
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesTableViewCell", for: indexPath) as? ImagesTableViewCell else {return UITableViewCell()}
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell else {return UITableViewCell()}
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonsTableViewCell", for: indexPath) as? ButtonsTableViewCell else {return UITableViewCell()}
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
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
