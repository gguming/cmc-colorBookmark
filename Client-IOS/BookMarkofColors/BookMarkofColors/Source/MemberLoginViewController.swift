//
//  MemberLoginViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class MemberLoginViewController: UIViewController {
    lazy var dataManager: LoginDataManager = LoginDataManager()
    var emailValue = ""
    var passwordValue = ""
    
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var UnderLineView: UIView!
    @IBOutlet weak var JoinButton: UIButton!
    @IBOutlet weak var JoinLabel: UILabel!
    @IBOutlet weak var FindPasswordButton: UIButton!
    
    @IBAction func GoBackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func JoinButtonTapped(_ sender: Any) {
        passwordValue = PasswordTextField.text!
        print(emailValue)
        print(passwordValue)
        let loginInput = LoginRequest(email: emailValue, password: passwordValue)
        dataManager.postLogin(loginInput, delegate: self)
    }
    
    @IBAction func FindPasswordButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FindPasswordViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    let pinkColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
    let changedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    override func viewDidLoad() {
        UnderLineView.isHidden = true
        JoinButton.isEnabled = false
        FindPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        JoinButton.layer.cornerRadius = 22
        PasswordTextField.layer.cornerRadius = 5
        self.PasswordTextField.addTarget(self, action: #selector(self.UnderlineTextField(_:)), for: .editingChanged)
        UnderLineFindPasswordButton()
        super.viewDidLoad()
        
        PasswordEditing()
    }
    
    @objc func UnderlineTextField(_ sender: Any?) {
        UnderLineView.isHidden = false
        JoinButton.isEnabled = true
        JoinButton.backgroundColor = pinkColor
        JoinLabel.textColor = changedTextColor
    }
    
    func UnderLineFindPasswordButton() {
        let text = "비밀번호를 잊으셨나요?"
        let attribute = NSMutableAttributedString(string: text)
        let textColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0.5725490196, alpha: 1)
        let underLine = NSUnderlineStyle.single.rawValue
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: text.count))
        attribute.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: underLine, range: NSRange(location: 0, length: text.count))
        self.FindPasswordButton.setAttributedTitle(attribute, for: .normal)
    }
    
    func PasswordEditing() {
        print("하하")
        if PasswordTextField.isEditing {
            print("카캌")
            PasswordTextField.isSecureTextEntry = true
        }
    }
        
}

extension MemberLoginViewController {
    func loginSuccess() {
        UserDefaults.standard.set(emailValue, forKey: "email")
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        changeRootViewController(vc)
    }
}
