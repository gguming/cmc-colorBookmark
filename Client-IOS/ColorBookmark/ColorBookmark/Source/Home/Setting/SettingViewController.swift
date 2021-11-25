//
//  SettingViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/10.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let settingTitle = ["알림", "암호", "배경음악"]
//    var onOffValue = [false, false, false]
    var currentCellNumber = [0,1,2]
    
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section != 3 && indexPath.section != 4 {
            let cell = SettingTableview.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
           
            switch indexPath.section {
            case 0:
                cell.TitleLabel.text = settingTitle[indexPath.section]
                cell.ContentLabel.text = "20:00 PM"
                cell.cellNumber = currentCellNumber[indexPath.section]
                print("셀 넘버")
                
            
                if  SettingInfo.shared.settingOnOff[indexPath.section] == true {
                    cell.SettingSwitch.isOn = true
                }
                else {
                    cell.SettingSwitch.isOn = false
                }
                
            case 1:
                cell.TitleLabel.text = settingTitle[indexPath.section]
                cell.ContentLabel.text = "분실한 비밀번호는 찾을 수 없어요!"
                cell.cellNumber = currentCellNumber[indexPath.section]
                print("셀 넘버")
                print(currentCellNumber)
                
                if  SettingInfo.shared.settingOnOff[indexPath.section] == true {
                    cell.SettingSwitch.isOn = true
                }
                else {
                    cell.SettingSwitch.isOn = false
                }
                
            case 2:
                cell.TitleLabel.text = settingTitle[indexPath.section]
                cell.ContentLabel.text = "배경음악을 끌 수 있어요!"
                cell.cellNumber = currentCellNumber[indexPath.section]
                print("셀 넘버")
                print(currentCellNumber)
                
                if  SettingInfo.shared.settingOnOff[indexPath.section] == true {
                    cell.SettingSwitch.isOn = true
                }
                else {
                    cell.SettingSwitch.isOn = false
                }

            default:
                break
            }
            
            cell.cellDelegate = self
            
            return cell
        }
        
        let cell = SettingTableview.dequeueReusableCell(withIdentifier: "SecondSettingTableViewCell", for: indexPath) as! SecondSettingTableViewCell
        
        switch indexPath.section {
        case 3: cell.SecondSettingTitleLabel.text = "백업과 복원"
        case 4: cell.SecondSettingTitleLabel.text = "색갈피는?"
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}

extension SettingViewController: PresentVCDelegate {
    func presentMiniCodeVC() {
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = homeStoryboard.instantiateViewController(withIdentifier: "MiniCodeViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
