//
//  LoginMainViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class LoginMainViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var ContinueButton: UIButton!
    override func viewDidLoad() {
        ContinueButton.layer.cornerRadius = 25
        EmailTextField.layer.cornerRadius = 5
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
