//
//  LogoutViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/24.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LogoutViewController: UIViewController {
 
    let yesColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0.5725490196, alpha: 1)
//    #192293
    let CCC = #colorLiteral(red: 0.6352941176, green: 1, blue: 0.2117647059, alpha: 1)
    let noColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    @IBAction func YesButtonTapped(_ sender: Any) {
        print("yes")
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
        
        Constant.jwt = nil
        Constant.nickname = nil
        Constant.setting_0 = "N"
        Constant.setting_1 = "N"
        Constant.setting_2 = "N"
        Constant.miniCode = nil
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController")
        changeRootViewController(vc)
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
