//
//  LoginMainViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit
import Alamofire

class LoginMainViewController: UIViewController {
    
    lazy var dataManager: EmailCheckDataManager = EmailCheckDataManager()
    
    @IBOutlet weak var CheckEmailInputLabel: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var UnderLineView: UIView!
    @IBOutlet weak var ContinueLabel: UILabel!
    @IBOutlet weak var ContinueButton: UIButton!
    
    @IBAction func BackToLoginPageVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ContinueButtonTapped(_ sender: Any) {
        let emailValue: String = EmailTextField.text!
        let email: Parameters = ["email" : emailValue]
        dataManager.EmailCheck(email, delegate: self)
    }
    
    let pinkColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
    let changedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    override func viewDidLoad() {
        UnderLineView.isHidden = true
        ContinueButton.isEnabled = false
        ContinueButton.layer.cornerRadius = 22
        EmailTextField.layer.cornerRadius = 5
        self.EmailTextField.addTarget(self, action: #selector(self.UnderlineTextField(_:)), for: .editingChanged)
        
        super.viewDidLoad()
 
    }
    
    @objc func UnderlineTextField(_ sender: Any?) {
        UnderLineView.isHidden = false
        ContinueButton.isEnabled = true
        ContinueButton.backgroundColor = pinkColor
        ContinueLabel.textColor = changedTextColor
    }
}

extension LoginMainViewController {
    func emailAlreadyExist() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemberLoginViewController") as? MemberLoginViewController else { return }
        vc.emailValue = EmailTextField.text!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func availbleEmail() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SigninPasswordViewController") as? SigninPasswordViewController else { return }
        vc.emailValue = EmailTextField.text!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func failedToCheckEmail(result: EmailCheckResponse) {
        CheckEmailInputLabel.text = result.message
        self.CheckEmailInputLabel.reloadInputViews()
    }
}
