//
//  MyPageViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/10.
//

import UIKit

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MypageTableview.frame.width * 0.15
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    
}
