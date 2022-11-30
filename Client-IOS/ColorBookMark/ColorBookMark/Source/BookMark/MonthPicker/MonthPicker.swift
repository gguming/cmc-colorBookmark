//
//  MonthPicker.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/09.
//


import UIKit

class MonthPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var months = [String]()
    var years = [Int]()
    
    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            selectRow(month - 1, inComponent: 1, animated: false)
        }
    }
    
    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            if let firstYearIndex = years.firstIndex(of: year) {
                selectRow(firstYearIndex, inComponent: 0, animated: true)
            }
        }
    }
    
    var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    func commonSetup() {
        // population years
//        var year = Calendar(identifier: .gregorian).component(.year, from: Date())
        let years = Array(2021...2031)
//        if years.count == 0 {
//            var year = Calendar(identifier: .gregorian).component(.year, from: Date())
//            for _ in 1...15 {
//                years.append(year)
//                year += 1
//            }
//        }
        self.years = years
        
        // population months with localized names
        let months: [String] = ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월",]
//        var month = 0
//        for _ in 1...12 {
//            months.append(DateFormatter().monthSymbols[month].capitalized)
//            month += 1
//        }
        self.months = months
        
        delegate = self
        dataSource = self
        
        let currentMonth = Calendar(identifier: .gregorian).component(.month, from: Date())
        selectRow(currentMonth - 1, inComponent: 1, animated: false)
    }
    
    // Mark: UIPicker Delegate / Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(years[row])"
            
        case 1:
            return months[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
           
            return months.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = selectedRow(inComponent: 1) + 1
        let year = years[selectedRow(inComponent: 0)]
        if let block = onDateSelected {
            block(month, year)
        }
        
        self.month = month
        self.year = year
    }
    
    
    
}

