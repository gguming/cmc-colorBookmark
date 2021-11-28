//
//  FindPasswordViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class FindPasswordViewController: UIViewController {
    lazy var dataManager: FindPasswordDataManager = FindPasswordDataManager()
    var emailValue = ""
    
    @IBOutlet weak var FindPasswordTextField: UITextField!
    
    @IBAction func GoBackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SendButtonTapped(_ sender: Any) {
        emailValue = FindPasswordTextField.text!
        print(emailValue)
        let passwordInput = FindPasswordRequest(email: emailValue)
        dataManager.postPassword(passwordInput, delegate: self)
    }
    
    @IBOutlet weak var SendLabel: UILabel!
    @IBOutlet weak var UnderLineView: UIView!
    @IBOutlet weak var SendButton: UIButton!
    let pinkColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
    let changedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    override func viewDidLoad() {
        UnderLineView.isHidden = true
        SendButton.isEnabled = false
        SendButton.layer.cornerRadius = 22
        FindPasswordTextField.layer.cornerRadius = 5
        self.FindPasswordTextField.addTarget(self, action: #selector(self.UnderlineTextField(_:)), for: .editingChanged)
        super.viewDidLoad()

    }
    
    @objc func UnderlineTextField(_ sender: Any?) {
        UnderLineView.isHidden = false
        SendButton.isEnabled = true
        SendButton.backgroundColor = pinkColor
        SendLabel.textColor = changedTextColor
    }

    
    func SendPasswordSuccess() {
        dismiss(animated: true, completion: nil)
    }
}
