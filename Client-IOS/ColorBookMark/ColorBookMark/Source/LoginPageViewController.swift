//
//  LoginPageViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/09.
//

import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginPageViewController: UIViewController {
    lazy var dataManager: KakaoLoginDataManager = KakaoLoginDataManager()
    
    @IBAction func KakaoLogin(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount { [self](oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
               print("loginWithKakaoAccount() success.")
               _ = oauthToken
               let accessToken = oauthToken?.accessToken
               print("에세스 토큰")
               print(accessToken)
               
               let kakaoLoginInput = KakaoLoginRequest(accessToken: accessToken!)
               dataManager.getKakaoLoginJwt(kakaoLoginInput, delegate: self)
               let storyboard = UIStoryboard(name: "Login", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "KakaoNicknameViewController") as! KakaoNicknameViewController
               changeRootViewController(vc)
           }
        }
    }
    
    @IBAction func AppleLogin(_ sender: Any) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
    @IBAction func EmailLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginMainViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    let pinkColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0.5725490196, alpha: 1)
    
    override func viewDidLoad() {
        let topHeight = view.frame.height * 1/4
        iconImage.topAnchor.constraint(equalTo: view.topAnchor, constant: topHeight).isActive = true
        kakaoButton.layer.cornerRadius = 20
        appleButton.layer.cornerRadius = 20
        emailButton.layer.cornerRadius = 20
        appleButton.layer.borderWidth = 1
        appleButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
        let attributedString = NSMutableAttributedString(string: PageLabel.text!)
        attributedString.addAttribute(.foregroundColor, value: pinkColor, range: (PageLabel.text! as NSString).range(of:"색갈피"))
        PageLabel.attributedText = attributedString
        super.viewDidLoad()
    }

}

extension LoginPageViewController : ASAuthorizationControllerDelegate  {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            print("👨‍🍳 \(user)")
            if let email = credential.email {
                print("✉️ \(email)")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error \(error)")
    }
}
