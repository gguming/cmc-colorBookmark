//
//  ChangeNicknameViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/26.
//

import UIKit

class ChangeNicknameViewController: BaseViewController {
    
    lazy var dataManager: ChangeNicknameDataManager = ChangeNicknameDataManager()

    @IBOutlet weak var NicknameTextField: UITextField!
    @IBOutlet weak var ChangeNicknameLabel: UILabel!
    @IBOutlet weak var ChangeNicknameButton: UIButton!
    
    @IBAction func BackToMypageVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ChangeNicknameButtonTapped(_ sender: Any) {
        let nickname = NicknameTextField.text
        if Constant.setting_1 == "Y" {
            let changeNicknameInput = ChangeNicknameRequest(nickname: nickname!, miniCode: Constant.miniCode)
            dataManager.changeNickname(changeNicknameInput, delegate: self)
        }
        else {
            let changeNicknameInput = ChangeNicknameRequest(nickname: nickname!, miniCode: nil)
            dataManager.changeNickname(changeNicknameInput, delegate: self)
        }
       
    }
    
    let changedBackgroundColor = #colorLiteral(red: 1, green: 0.2765524387, blue: 0.6389049292, alpha: 1)
    let changedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let unabledTextColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    let unabledBackgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    
    override func viewDidLoad() {
//        view.backgroundColor = UIColor(white: 1, alpha: 1)
//        base.backgroundColor = UIColor.white.withAlphaComponent(1)
        ChangeNicknameButton.layer.cornerRadius = 22
        NicknameTextField.layer.cornerRadius = 5
//        ChangeNicknameButton.isEnabled = false
//        ChangeNicknameButton.backgroundColor = unabledBackgroundColor
        self.NicknameTextField.addTarget(self, action: #selector(self.UnderlineNicknameTextField(_:)), for: .editingChanged)

        super.viewDidLoad()
    }
    
    @objc func UnderlineNicknameTextField(_ sender: Any?) {
        if PossibleNickName(nickname: NicknameTextField.text) {
            ChangeNicknameButton.isEnabled = true
            ChangeNicknameButton.backgroundColor = changedBackgroundColor
            ChangeNicknameLabel.textColor = changedTextColor
        }
        else {
            ChangeNicknameButton.isEnabled = false
            ChangeNicknameButton.backgroundColor = unabledBackgroundColor
            ChangeNicknameLabel.textColor = unabledTextColor
        }
    }
    
    func PossibleNickName(nickname: String?) -> Bool {
        if Int(nickname?.count ?? 0) > 0 {
            return true
        }
        return false
    }
}

extension ChangeNicknameViewController {
    func changeNicknameSuccess() {
        let newNickname = NicknameTextField.text
        Constant.nickname = newNickname
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }
}
