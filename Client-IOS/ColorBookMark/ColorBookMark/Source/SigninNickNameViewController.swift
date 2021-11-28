//
//  SigninNickNameViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class SigninNickNameViewController: UIViewController {
    lazy var signinDataManager: SigninDataManager = SigninDataManager()
    lazy var loginDataManager: LoginAfterSigninDataManager = LoginAfterSigninDataManager()
    
    
    var emailValue = ""
    var passwordValue = ""
    var nicknameValue = ""
    
    @IBOutlet weak var NickNameTextField: UITextField!
    @IBOutlet weak var NickNameUnderLineView: UIView!
    @IBOutlet weak var AgreementLabel: UILabel!
    @IBOutlet weak var AgreementView: UIView!
    @IBOutlet weak var JoinButton: UIButton!
    @IBOutlet weak var JoinLabel: UILabel!
    
    @IBAction func GoBackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func JoinButtonTapped(_ sender: Any) {
        nicknameValue = NickNameTextField.text!
        print(emailValue)
        print(passwordValue)
        print(nicknameValue)
        let signinInput = SigninRequest(email: emailValue, password: passwordValue, nickname: nicknameValue)
        signinDataManager.postSignin(signinInput, delegate: self)
    }
    
    let changedBackgroundColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
    let changedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let unabledTextColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    let unabledBackgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    
    override func viewDidLoad() {
        
        configureLabel()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(fixedLabelTapped(_:)))
          view.addGestureRecognizer(recognizer)
        JoinButton.layer.cornerRadius = 22
        AgreementView.layer.cornerRadius = 7
        NickNameTextField.layer.cornerRadius = 5
        NickNameUnderLineView.isHidden = true
        self.NickNameTextField.addTarget(self, action: #selector(self.UnderlineNickNameTextField(_:)), for: .editingChanged)
        
        super.viewDidLoad()
    }
    
    @objc func fixedLabelTapped(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: AgreementLabel)
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)

        if let privacyPolicyRect = AgreementLabel.boundingRectForCharacterRange(subText: "개인정보처리방침"), privacyPolicyRect.contains(point) {
            let privacyPolicyVC = storyBoard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")
            self.present(privacyPolicyVC, animated: true)
        }
        
        if let termsOfUseRect = AgreementLabel.boundingRectForCharacterRange(subText: "TermsOfUseViewController"),
           termsOfUseRect.contains(point) {
            let termsOfUseVC = storyBoard.instantiateViewController(withIdentifier: "TermsOfUseViewController")
            self.present(termsOfUseVC, animated: true)
        }
        
    }
    
    func configureLabel() {
        
      let privacyPolicy = "개인정보처리방침"
      let termsOfUse = "서비스이용약관"
      let generalText = String(format: "가입시 %@ 및 %@에 동의하게됩니다", privacyPolicy, termsOfUse)
        let mediumFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        let boldFont = UIFont.systemFont(ofSize: 12, weight: .bold)

        let pinkColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
        let grayColor = #colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)
        
        let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor:grayColor, .font: mediumFont]
        let linkAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: pinkColor, .font: boldFont]
        
        let mutableString = NSMutableAttributedString()
        mutableString.append(NSAttributedString(string: generalText, attributes: generalAttributes))
        mutableString.setAttributes(linkAttributes, range: (generalText as NSString).range(of: privacyPolicy))
        mutableString.setAttributes(linkAttributes, range: (generalText as NSString).range(of: termsOfUse))
        
        AgreementLabel.attributedText = mutableString
    }
    
    @objc func UnderlineNickNameTextField(_ sender: Any?) {
        NickNameUnderLineView.isHidden = false
        if PossibleNickName(nickname: NickNameTextField.text) {
            JoinButton.isEnabled = true
            JoinButton.backgroundColor = changedBackgroundColor
            JoinLabel.textColor = changedTextColor
        }
        else {
            JoinButton.isEnabled = false
            JoinButton.backgroundColor = unabledBackgroundColor
            JoinLabel.textColor = unabledTextColor
        }
    }
    
    func PossibleNickName(nickname: String?) -> Bool {
        if Int(nickname?.count ?? 0) < 7 {
            return true
        }
        return false
    }

}

extension SigninNickNameViewController {
    func SigninSuccess() {
        let loginInput = LoginRequest(email: emailValue, password: passwordValue)
        loginDataManager.postLoginAfterSignin(loginInput, delegate: self)
    }
    
    func LoginSuccess() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        changeRootViewController(vc)
    }
}
