//
//  MonthPickerViewController.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/09.
//

import UIKit

class MonthPickerViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var calanderbackView: UIView!
    @IBOutlet weak var calanderView: UIView!
    @IBOutlet weak var completeBtn: UIButton!
    
    var changeMonthDelegate: ChangeMonthDelegate?
    var month: String?
    var monthForBtn: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        let expiryDatePicker = MonthPicker()
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            let string = String(format: "%02d-%02d", year, month)
            let string22 = String(format: "%02d.%2d", year, month)
            print(string)
            self.month = string
            self.monthForBtn = string22
            
            print(self.month as Any)
            print(self.monthForBtn as Any)
            // should show something like 05/2015
        }
        expiryDatePicker.frame = CGRect(x: 0, y: 0, width: calanderView.bounds.width, height: calanderView.bounds.height)
        
        calanderView.addSubview(expiryDatePicker)
        
        setButton()
    }
    
    func setButton() {
        calanderbackView.layer.cornerRadius = 10
        calanderbackView.clipsToBounds = true
        completeBtn.layer.cornerRadius = 33/2
        
        backBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        completeBtn.addTarget(self, action: #selector(completeBtnTapped), for: .touchUpInside)
        
        
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func completeBtnTapped() {
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BookmarkViewController") as? BookmarkViewController else {return}
        if month != nil {
            changeMonthDelegate?.changeMonth(month: month!, monthForBtn: monthForBtn!)
            self.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}

protocol ChangeMonthDelegate {
    func changeMonth(month: String, monthForBtn: String)
}
