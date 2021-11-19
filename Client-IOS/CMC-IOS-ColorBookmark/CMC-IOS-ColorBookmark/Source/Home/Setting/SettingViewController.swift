//
//  SettingViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/10.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let settingTitle = ["알림", "암호", "감정이름", "배경음악"]
    
    @IBAction func ToMypageButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController
        vc!.modalPresentationStyle = .fullScreen
        present(vc!, animated: true, completion: nil)
    }
    
    @IBOutlet weak var SettingTableview: UITableView!
    @IBAction func BackToMainVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingTableview.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        
        SettingTableview.delegate = self
        SettingTableview.dataSource = self
        SettingTableview.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section != 4 && indexPath.section != 5 {
            let cell = SettingTableview.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
           
            switch indexPath.section {
            case 0:
                cell.TitleLabel.text = settingTitle[indexPath.section]
                cell.ContentLabel.text = "20:00 PM"
                
            case 1:
                cell.TitleLabel.text = settingTitle[indexPath.section]
                cell.ContentLabel.text = "분실한 비밀번호는 찾을 수 없어요!"
                
            case 2:
                cell.TitleLabel.text = settingTitle[indexPath.section]
                cell.ContentLabel.text = "감정 기록 화면에서 감정 아래에 이름이 표시돼요!"
                
            case 3:
                cell.TitleLabel.text = settingTitle[indexPath.section]
                cell.ContentLabel.text = "배경음악을 끌 수 있어요!"
            default:
                break
            }
            return cell
        }
        
        let cell = SettingTableview.dequeueReusableCell(withIdentifier: "SecondSettingTableViewCell", for: indexPath) as! SecondSettingTableViewCell
        
        switch indexPath.section {
        case 4: cell.SecondSettingTitleLabel.text = "백업과 복원"
        case 5: cell.SecondSettingTitleLabel.text = "색갈피는?"
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}
