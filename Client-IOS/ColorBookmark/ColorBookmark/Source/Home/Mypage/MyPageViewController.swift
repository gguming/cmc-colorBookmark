//
//  MyPageViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/10.
//

import UIKit

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var LogoutContainerView: UIView!
    
    let myPageTitle = ["닉네임 수정", "비밀변호 변경", "개인정보처리방침", "서비스이용약관", "로그아웃", "회원 탈퇴"]
    
    @IBAction func BackToSettingVCTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var AccountLabel: UILabel!
    @IBOutlet weak var MypageTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AccountLabel.text = UserDefaults.standard.string(forKey: "email")!
        MypageTableview.delegate = self
        MypageTableview.dataSource = self
        MypageTableview.separatorStyle = .none
        
        let bottomValue = view.frame.height * 0.35
        MypageTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomValue).isActive = true
        
        LogoutContainerView.isHidden = true
        
        guard let logoutView = storyboard?.instantiateViewController(withIdentifier: "LogoutViewController") else { return }
        addChild(logoutView)
        logoutView.view.layer.cornerRadius = 20
        logoutView.view.frame = LogoutContainerView.bounds
        LogoutContainerView.addSubview(logoutView.view)
  
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MypageTableview.dequeueReusableCell(withIdentifier: "MypageTableViewCell", for: indexPath) as! MypageTableViewCell
        cell.MypageLabel.text = myPageTitle[indexPath.section]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MypageTableview.frame.width * 0.15
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let logoutView = storyboard?.instantiateViewController(withIdentifier: "LogoutViewController") else { return }
        
        switch indexPath.section {
        case 0:
            let mypageStoryboard = UIStoryboard(name: "Mypage", bundle: nil)
            let vc = mypageStoryboard.instantiateViewController(withIdentifier: "ChangeNicknameViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 1:
            let mypageStoryboard = UIStoryboard(name: "Mypage", bundle: nil)
            let vc = mypageStoryboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 4:
            let HomeStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = HomeStoryboard.instantiateViewController(withIdentifier: "LogoutPopViewController")
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.view.backgroundColor = .black.withAlphaComponent(0.4)
            self.present(vc, animated: true, completion: nil)
        default:
            break
        }
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            LogoutContainerView.isHidden = true
        }
    }
}
