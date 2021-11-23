//
//  LogoutViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/24.
//

import UIKit

class LogoutViewController: UIViewController {
 
    let yesColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0.5725490196, alpha: 1)
    let noColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    @IBAction func YesButtonTapped(_ sender: Any) {
        print("yes")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
        vc.logoutAgree()
    }
    @IBAction func NoButtonTapped(_ sender: Any) {
        print("no")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
        vc.logoutDisagree()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        YesButton.layer.cornerRadius = 10
        NoButton.layer.cornerRadius = 10
        
        YesButton.backgroundColor = yesColor
        NoButton.backgroundColor = noColor

        // Do any additional setup after loading the view.
    }
    

}
