//
//  MonthPickerViewController.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/09.
//

import UIKit

class MonthPickerViewController: UIViewController {

    @IBOutlet weak var calanderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let expiryDatePicker = MonthPicker()
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            let string = String(format: "%02d/%d", month, year)
            NSLog(string) // should show something like 05/2015
        }
        expiryDatePicker.frame = CGRect(x: 0, y: 0, width: calanderView.bounds.width, height: calanderView.bounds.height)
        
        
        calanderView.addSubview(expiryDatePicker)
        calanderView.layer.borderWidth = 1
        calanderView.layer.borderColor = UIColor.black.cgColor
    }
    
    

   

}
