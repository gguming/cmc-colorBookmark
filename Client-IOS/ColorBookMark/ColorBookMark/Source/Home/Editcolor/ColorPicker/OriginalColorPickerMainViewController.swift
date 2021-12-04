//
//  OriginalColorPickerMainViewController.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/05.
//

import UIKit

class OriginalColorPickerMainViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    lazy var postcolorDataManager: PostColorDataManager = PostColorDataManager()
    
    @available(iOS 14.0, *)
    @IBAction func saveBtnTapped(_ sender: Any) {
//        presentAlert()
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @available(iOS 14.0, *)
//    private func presentAlert() {
//        let alert = UIAlertController(title: "감정 이름 설정", message: nil, preferredStyle: .alert)
//        alert.addTextField(configurationHandler: nil)
//        let ok = UIAlertAction(title: "저장", style: .default) { action in
//            let colorName = alert.textFields?[0].text
//            let colorInfo = ColorPickerInfo.shared.color
//
//            if colorName?.count == 0 {
//                self.presentBottomAlert(message: "감정 이름을 입력해 주세요!")
//                self.presentAlert()
//            } else if colorName?.count ?? 6 > 5 {
//                self.presentBottomAlert(message: "5자 이하로 입력해 주세요!")
//                self.presentAlert()
//
//            }else if colorInfo == nil {
//                self.presentBottomAlert(message: "컬러를 골라주세요")
//            }else {
//
//                let request = PostColorRequest(color: colorInfo!, colorName: "\(colorName ?? "")")
//                print(request)
//                self.postcolorDataManager.postColor(request, delegate: self)
//                print(1)
//            }
//
//
//        }
//        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        alert.addAction(ok)
//        alert.addAction(cancel)
//
////        let confirm = UIAlertAction(
//        self.present(alert, animated: true, completion: nil)
//
//    }

}
