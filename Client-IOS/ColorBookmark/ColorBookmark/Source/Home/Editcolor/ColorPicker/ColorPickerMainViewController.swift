//
//  ColorPickerMainViewController.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/20.
//

import UIKit

class ColorPickerMainViewController: UIViewController {
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @available(iOS 14.0, *)
    @IBAction func saveBtnTapped(_ sender: Any) {
        presentAlert()
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @available(iOS 14.0, *)
    private func presentAlert() {
        let alert = UIAlertController(title: "감정 이름 설정", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let ok = UIAlertAction(title: "저장", style: .default) { action in
            let colorName = alert.textFields?[0].text
            
            if colorName?.count == 0 {
                self.presentBottomAlert(message: "감정 이름을 입력해 주세요!")
            } else if colorName?.count ?? 6 > 5 {
                self.presentBottomAlert(message: "5자 이하로 입력해 주세요!")
            } else {
                print(1)
            }
            
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
//        let confirm = UIAlertAction(
        self.present(alert, animated: true, completion: nil)
        
    }
    

   
}


