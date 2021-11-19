//
//  LoginPageViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/09.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginPageViewController: UIViewController {
    
    @IBAction func KakaoLogin(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
               print("loginWithKakaoAccount() success.")
               _ = oauthToken
               let accessToken = oauthToken?.accessToken
               JwtInfo.shared.jwtValue = accessToken
               print("카카오 토큰 값 ")
               print(JwtInfo.shared.jwtValue)
               let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
           }
        }
    }
    
    @IBAction func AppleLogin(_ sender: Any) {
    }
    
    @IBAction func EmailLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginMainViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    let pinkColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0.5725490196, alpha: 1)
    
    override func viewDidLoad() {
        kakaoButton.layer.cornerRadius = 23
        appleButton.layer.cornerRadius = 23
        emailButton.layer.cornerRadius = 23
        appleButton.layer.borderWidth = 1
        appleButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
        let attributedString = NSMutableAttributedString(string: PageLabel.text!)
        attributedString.addAttribute(.foregroundColor, value: pinkColor, range: (PageLabel.text! as NSString).range(of:"색갈피"))
        PageLabel.attributedText = attributedString
        super.viewDidLoad()
    }

}
