//
//  MemberLoginViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class MemberLoginViewController: UIViewController {

    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var JoinButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    override func viewDidLoad() {
        findPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        JoinButton.layer.cornerRadius = 25
        PasswordTextField.layer.cornerRadius = 5
        super.viewDidLoad()
    }
    

}
