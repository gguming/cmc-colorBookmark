//
//  MemberLoginViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/01.
//

import UIKit

class MemberLoginViewController: UIViewController {

    @IBOutlet weak var findPasswordButton: UIButton!
    override func viewDidLoad() {
        findPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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
