//
//  EditDiaryViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/07.
//

import UIKit

class EditDiaryViewController: UIViewController {
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableview.register(UINib(nibName: "ColorTableViewCell", bundle: nil), forCellReuseIdentifier: "ColorTableViewCell")
        tableview.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        
        tableview.dataSource = self
        tableview.delegate = self
        
    }
    
    
    

}

extension EditDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as? HeaderTableViewCell else {return UITableViewCell()}
            cell.setUI()
            if Constant.panelState == 0{
                cell.reloadInputViews()
            } else {
                cell.reloadInputViews()
            }
            return cell
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ColorTableViewCell", for: indexPath) as? ColorTableViewCell else {return UITableViewCell()}
        
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as? TextTableViewCell else {return UITableViewCell()}
        
            return cell
            
        default:
            return UITableViewCell()
        }

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case 0:
            return 80
            
        case 1:
            return 169
       
        case 2:
            return 150
        default:
            return 0
        }
        
    }
}
