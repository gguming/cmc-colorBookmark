//
//  EditDiaryViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/07.
//

import UIKit

class EditDiaryViewController: UIViewController  {
   
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 셀 등록
        tableview.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableview.register(UINib(nibName: "ColorTableViewCell", bundle: nil), forCellReuseIdentifier: "ColorTableViewCell")
        tableview.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        tableview.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        tableview.register(UINib(nibName: "AudioTableViewCell", bundle: nil), forCellReuseIdentifier: "AudioTableViewCell")
        tableview.register(UINib(nibName: "EditBtnTableViewCell", bundle: nil), forCellReuseIdentifier: "EditBtnTableViewCell")
       
        
        tableview.dataSource = self
        tableview.delegate = self
        
    }

}

extension EditDiaryViewController: EditBtnDelegate{
    func presentEditVC() {
        print(1)
        let sb = UIStoryboard(name: "EditColor", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "EditColorViewController") as? EditColorViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
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
        
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as? TextTableViewCell else {return UITableViewCell()}
        
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else {return UITableViewCell()}
        
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioTableViewCell", for: indexPath) as? AudioTableViewCell else {return UITableViewCell()}
        
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
