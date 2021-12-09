//
//  MyPageViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/10.
//

import UIKit

class MyPageViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var LogoutContainerView: UIView!
    
    let myPageTitle = ["닉네임 수정", "비밀변호 변경", "개인정보처리방침", "서비스이용약관", "로그아웃", "회원 탈퇴"]
    
    @IBAction func BackToSettingVCTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var LoginLabel: UILabel!
    @IBOutlet weak var AccountLabel: UILabel!
    @IBOutlet weak var MypageTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MypageTableview.separatorStyle = .none
        print("확인용")
        print(Constant.account as Any)
        print(Constant.nickname as Any)
        if Constant.account == "Kakao" {
            AccountLabel.text = "Kakao Account"
            LoginLabel.text = "카카오로 로그인 하셨네요!"
        }
        else if Constant.account == "Apple" {
            AccountLabel.text = "Apple Account"
            LoginLabel.text = "애플 아이디로 로그인 하셨네요!"
        }
        else {
            AccountLabel.text = Constant.email
            LoginLabel.text = "이메일로 로그인 하셨네요!"
        }
        
//        if Constant.email == "Kakao" {
//            AccountLabel.text = "Kakao Account"
//            LoginLabel.text = "카카오로 로그인 하셨네요!"
//        }
//
//        if Constant.email == "Apple" {
//            AccountLabel.text = "Apple Account"
//            LoginLabel.text = "애플 아이디로 로그인 하셨네요!"
//        }
//
//        else {
//            AccountLabel.text = Constant.email
//            LoginLabel.text = "이메일로 로그인 하셨네요!"
//        }
        
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
        return MypageTableview.frame.width * 0.15 + 12
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let logoutView = storyboard?.instantiateViewController(withIdentifier: "LogoutViewController") else { return }
        
        switch indexPath.section {
        case 0:
            if Constant.setting_1 == "Y" {
                let mypageStoryboard = UIStoryboard(name: "Mypage", bundle: nil)
                let vc = mypageStoryboard.instantiateViewController(withIdentifier: "MyPageMiniCodeViewController")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
            let mypageStoryboard = UIStoryboard(name: "Mypage", bundle: nil)
            let vc = mypageStoryboard.instantiateViewController(withIdentifier: "ChangeNicknameViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 1:
            if Constant.account != "ColorBookMark" {
                let HomeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let vc = HomeStoryboard.instantiateViewController(withIdentifier: "ChangePasswordCheckPopViewController")
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.view.backgroundColor = .black.withAlphaComponent(0.4)
                self.present(vc, animated: true, completion: nil)
            }
            else {
                let mypageStoryboard = UIStoryboard(name: "Mypage", bundle: nil)
                let vc = mypageStoryboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }

        case 2:
            let mypageStoryboard = UIStoryboard(name: "Mypage", bundle: nil)
            let vc = mypageStoryboard.instantiateViewController(withIdentifier: "TermsOfUseViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 3:
            let mypageStoryboard = UIStoryboard(name: "Mypage", bundle: nil)
            let vc = mypageStoryboard.instantiateViewController(withIdentifier: "TermsofServiceViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 4:
            let HomeStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = HomeStoryboard.instantiateViewController(withIdentifier: "LogoutPopViewController")
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.view.backgroundColor = .black.withAlphaComponent(0.4)
            self.present(vc, animated: true, completion: nil)
            
        case 5:
            let HomeStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = HomeStoryboard.instantiateViewController(withIdentifier: "DeleteAccountPopViewController")
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
