//
//  FindPasswordViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var FindPasswordTextField: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    override func viewDidLoad() {
        SendButton.layer.cornerRadius = 25
        FindPasswordTextField.layer.cornerRadius = 5
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
