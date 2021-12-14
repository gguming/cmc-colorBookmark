//
//  TermsofServiceViewController.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/04.
//

import UIKit

class TermsofServiceViewController: UIViewController {

    @IBOutlet var selfView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BackToVC))
        selfView.addGestureRecognizer(tapGesture)
        selfView.isUserInteractionEnabled = true
    }
    
    @objc func BackToVC() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func xBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
