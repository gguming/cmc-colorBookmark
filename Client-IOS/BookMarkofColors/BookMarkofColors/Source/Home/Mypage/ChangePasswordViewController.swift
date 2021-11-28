//
//  ChangePasswordViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/24.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    lazy var dataManager: ChangePasswordDataManager = ChangePasswordDataManager()
    var passwordCheck: String? = nil
    
    @IBOutlet weak var PasswordChangeTextField: UITextField!
    @IBOutlet weak var PasswordChangeUnderLineView: UIView!
    @IBOutlet weak var PasswordChangeGuideLabel: UILabel!
    
    @IBOutlet weak var PasswordChangeCheckTextField: UITextField!
    @IBOutlet weak var PasswordChangeCheckUnderLineView: UIView!
    @IBOutlet weak var PasswordChangeCheckGuideLabel: UILabel!
       
    @IBOutlet weak var ChangePasswordButton: UIButton!
    @IBOutlet weak var ChangePasswordLabel: UILabel!

    @IBAction func BackToMypageVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ChangePasswordButtonTapped(_ sender: Any) {
        let password_1 = PasswordChangeTextField.text
        let password_2 = PasswordChangeCheckTextField.text
        let changePasswordInput = ChangePasswordRequest(password1: password_1!, password2: password_2!)
        dataManager.changePassword(changePasswordInput, delegate: self)
    }
    
    let changedBackgroundColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
    let changedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let unabledTextColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    let unabledBackgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    
    override func viewDidLoad() {
        ChangePasswordButton.layer.cornerRadius = 22
        PasswordChangeTextField.layer.cornerRadius = 5
        PasswordChangeCheckTextField.layer.cornerRadius = 5
        
        PasswordChangeUnderLineView.isHidden = true
        PasswordChangeGuideLabel.isHidden = true
        PasswordChangeCheckUnderLineView.isHidden = true
        PasswordChangeCheckGuideLabel.isHidden = true
        ChangePasswordButton.isEnabled = false
        PasswordChangeCheckTextField.isEnabled = false
        self.PasswordChangeTextField.addTarget(self, action: #selector(self.UnderlinePasswordTextField(_:)), for: .editingChanged)
        self.PasswordChangeCheckTextField.addTarget(self, action: #selector(self.UnderlinePasswordCheckTextField(_:)), for: .editingChanged)
        
        PasswordEditing()
        super.viewDidLoad()
 
    }
    
    func PasswordEditing() {
        if PasswordChangeTextField.isEditing{
            PasswordChangeTextField.isSecureTextEntry = true
        }
        
        if PasswordChangeCheckTextField.isEditing{
            PasswordChangeCheckTextField.isSecureTextEntry = true
        }
       
    }

    @objc func UnderlinePasswordTextField(_ sender: Any?) {
        PasswordChangeUnderLineView.isHidden = false
        PasswordChangeTextField.isSecureTextEntry = true
        if PossiblePassword(password: PasswordChangeTextField.text) {
            PasswordChangeGuideLabel.isHidden = false
            PasswordChangeCheckTextField.isEnabled = true
        }
        passwordCheck = PasswordChangeTextField.text
    }
    
    @objc func UnderlinePasswordCheckTextField(_ sender: Any?) {
        PasswordChangeCheckUnderLineView.isHidden = false
        PasswordChangeCheckTextField.isSecureTextEntry = true
        if passwordCheck == PasswordChangeCheckTextField.text {
            PasswordChangeCheckGuideLabel.isHidden = true
            ChangePasswordButton.isEnabled = true
            ChangePasswordButton.backgroundColor = changedBackgroundColor
            ChangePasswordLabel.textColor = changedTextColor
        }
        else {
            PasswordChangeCheckGuideLabel.isHidden = false
            ChangePasswordButton.isEnabled = false
            ChangePasswordButton.backgroundColor = unabledBackgroundColor
            ChangePasswordLabel.textColor = unabledTextColor
        }
    }
    
    func PossiblePassword(password: String?) -> Bool {
        if Int(password?.count ?? 0) > 5 {
            return true
        }
        return false
    }
    
    
}

extension ChangePasswordViewController {
    func changePasswordSuccess() {
        dismiss(animated: true, completion: nil)
    }
}
