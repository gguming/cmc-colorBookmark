//
//  DeleteAccountViewController.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/11/29.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class DeleteAccountViewController: UIViewController {
    lazy var dataManager: DeleteAccountDataManager = DeleteAccountDataManager()
    let yesColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0.5725490196, alpha: 1)
    let noColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    @IBAction func YesButtonTapped(_ sender: Any) {
        Constant.notFirstTimeLaunch = false
        
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("delete account success.")
                Constant.jwt = nil
                Constant.nickname = nil
                Constant.setting_0 = "N"
                Constant.setting_1 = "N"
                Constant.setting_2 = "N"
                Constant.miniCode = nil
                Constant.userId = nil
                Constant.email = nil
            }
            self.deleteAccountSuccess()
        }
        Constant.didLogin = false
        dataManager.deleteAccount(delegate: self)
    }
    
    @IBAction func NoButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 20
        YesButton.layer.cornerRadius = 10
        NoButton.layer.cornerRadius = 10
        
        YesButton.backgroundColor = yesColor
        NoButton.backgroundColor = noColor
    }
}

extension DeleteAccountViewController {
    func deleteAccountSuccess() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController")
        changeRootViewController(vc)
    }
}
