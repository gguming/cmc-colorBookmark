//
//  LoginMainViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class LoginMainViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var UnderLineView: UIView!
    @IBOutlet weak var ContinueLabel: UILabel!
    @IBOutlet weak var ContinueButton: UIButton!
    
    @IBAction func ContinueButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MemberLoginViewController")
        let vc = storyboard.instantiateViewController(withIdentifier: "SigininPasswordViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
