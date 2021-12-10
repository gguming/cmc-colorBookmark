//
//  KakaoNicknameViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/26.
//

import UIKit

class KakaoNicknameViewController: UIViewController {
    
    @IBOutlet weak var NickNameUnderLineView: UIView!
    @IBOutlet weak var NicknameTextField: UITextField!
    @IBOutlet weak var JoinButton: UIButton!
    @IBOutlet weak var JoinLabel: UILabel!
    
    @IBAction func JoinButtonTapped(_ sender: Any) {
        let nicknameValue = NicknameTextField.text
        Constant.nickname = nicknameValue
        Constant.didLogin = true
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        changeRootViewController(vc)
    }
    
    let changedBackgroundColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
    let changedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let unabledTextColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    let unabledBackgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    
    override func viewDidLoad() {
        
        JoinButton.layer.cornerRadius = 22
        JoinButton.isEnabled = false
        NicknameTextField.layer.cornerRadius = 5
        self.NicknameTextField.addTarget(self, action: #selector(self.UnderlineNickNameTextField(_:)), for: .editingChanged)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func UnderlineNickNameTextField(_ sender: Any?) {
        NickNameUnderLineView.isHidden = false
        if PossibleNickName(nickname: NicknameTextField.text) {
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
        if Int(nickname?.count ?? 0) > 0 {
            return true
        }
        return false
    }

}
