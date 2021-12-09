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

class LoginPageViewController: UIViewController, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
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
               print(accessToken ?? "")
               
               let kakaoLoginInput = KakaoLoginRequest(accessToken: accessToken!)
               dataManager.getKakaoLoginJwt(kakaoLoginInput, delegate: self)
               let storyboard = UIStoryboard(name: "Login", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "KakaoNicknameViewController") as! KakaoNicknameViewController
               changeRootViewController(vc)
           }
        }
    }
    
    @IBAction func AppleLogin(_ sender: Any) {
        Constant.account = "Apple"
        print("애플로그인1")
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
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
        
        print("애플로그인2")
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            if let email = credential.email {
                Constant.email = email
                print(Constant.email ?? "")
            }
            else {
                Constant.email = "Apple"
                print(Constant.email ?? "")
            }
            
            if let authorizationCode = credential.authorizationCode,
               let identityToken = credential.identityToken,
               let authString = String(data: authorizationCode, encoding: .utf8),
               let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
            }

        }
        
       
        Constant.didLogin = true
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "KakaoNicknameViewController") as! KakaoNicknameViewController
        changeRootViewController(vc)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("애플로그인3")
        print("error \(error)")
    }
}
