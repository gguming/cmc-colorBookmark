//
//  TermsOfUseLoginViewController.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/11.
//

import UIKit

class TermsOfUseLoginViewController: UIViewController {

    @IBOutlet var SelfView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BackToVC))
        SelfView.addGestureRecognizer(tapGesture)
        SelfView.isUserInteractionEnabled = true
    }
    
    @objc func BackToVC() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func xBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
