//
//  SigininPasswordViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class SigininPasswordViewController: UIViewController {

    var passwordCheck: String? = nil
    
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var PasswordUnderLineView: UIView!
    @IBOutlet weak var PasswordGuideLabel: UILabel!
    
    @IBOutlet weak var PasswordCheckTextField: UITextField!
    @IBOutlet weak var PasswordCheckUnderLineView: UIView!
    @IBOutlet weak var PasswordCheckGuideLabel: UILabel!
    
    @IBOutlet weak var ContinueButton: UIButton!
    @IBOutlet weak var ContinueLabel: UILabel!
    
    @IBAction func ContinueButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SigninNickNameViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    @IBAction func GoBackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    let changedBackgroundColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
    let changedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let unabledTextColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    let unabledBackgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    
    override func viewDidLoad() {
        ContinueButton.layer.cornerRadius = 22
        PasswordTextField.layer.cornerRadius = 5
        PasswordTextField.layer.cornerRadius = 5
        
        PasswordUnderLineView.isHidden = true
        PasswordGuideLabel.isHidden = true
        PasswordCheckUnderLineView.isHidden = true
        PasswordCheckGuideLabel.isHidden = true
        ContinueButton.isEnabled = false
        PasswordCheckTextField.isEnabled = false
        self.PasswordTextField.addTarget(self, action: #selector(self.UnderlinePasswordTextField(_:)), for: .editingChanged)
        self.PasswordCheckTextField.addTarget(self, action: #selector(self.UnderlinePasswordCheckTextField(_:)), for: .editingChanged)
        
        PasswordEditing()
        super.viewDidLoad()

 
    }
    
    func PasswordEditing() {
        if PasswordTextField.isEditing{
            PasswordTextField.isSecureTextEntry = true
        }
        
        if PasswordCheckTextField.isEditing{
            PasswordCheckTextField.isSecureTextEntry = true
        }
       
    }

    @objc func UnderlinePasswordTextField(_ sender: Any?) {
        PasswordUnderLineView.isHidden = false
        PasswordTextField.isSecureTextEntry = true
        if PossiblePassword(password: PasswordTextField.text) {
            PasswordGuideLabel.isHidden = false
            PasswordCheckTextField.isEnabled = true
        }
        passwordCheck = PasswordTextField.text
    }
    
    @objc func UnderlinePasswordCheckTextField(_ sender: Any?) {
        PasswordCheckUnderLineView.isHidden = false
        PasswordCheckTextField.isSecureTextEntry = true
        if passwordCheck == PasswordCheckTextField.text {
            PasswordCheckGuideLabel.isHidden = true
            ContinueButton.isEnabled = true
            ContinueButton.backgroundColor = changedBackgroundColor
            ContinueLabel.textColor = changedTextColor
        }
        else {
            PasswordCheckGuideLabel.isHidden = false
            ContinueButton.isEnabled = false
            ContinueButton.backgroundColor = unabledBackgroundColor
            ContinueLabel.textColor = unabledTextColor
        }
    }
    
    func PossiblePassword(password: String?) -> Bool {
        if Int(password?.count ?? 0) > 5 {
            return true
        }
        return false
    }
    

}
