//
//  ChangePasswordCheckViewController.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/05.
//

import UIKit

class ChangePasswordCheckViewController: UIViewController {

    @IBOutlet weak var ConfirmButton: UIButton!
    @IBAction func ConfirmButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 20
        ConfirmButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

}
