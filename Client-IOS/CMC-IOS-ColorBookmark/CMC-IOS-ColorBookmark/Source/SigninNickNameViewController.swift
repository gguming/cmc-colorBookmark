//
//  SigninNickNameViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class SigninNickNameViewController: UIViewController {

    @IBOutlet weak var NickNameTextField: UITextField!
    @IBOutlet weak var AgreementLabel: UILabel!
    @IBOutlet weak var AgreementView: UIView!
    @IBOutlet weak var JoinButton: UIButton!
    
    override func viewDidLoad() {
        
        configureLabel()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(fixedLabelTapped(_:)))
          view.addGestureRecognizer(recognizer)
        JoinButton.layer.cornerRadius = 25
        AgreementView.layer.cornerRadius = 7
        NickNameTextField.layer.cornerRadius = 5
        
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
        mutableString.append(NSAttributedString(string: generalText,attributes: generalAttributes))
        mutableString.setAttributes(linkAttributes, range: (generalText as NSString).range(of: privacyPolicy))
        mutableString.setAttributes(linkAttributes, range: (generalText as NSString).range(of: termsOfUse))
        
        AgreementLabel.attributedText = mutableString
    }

}
