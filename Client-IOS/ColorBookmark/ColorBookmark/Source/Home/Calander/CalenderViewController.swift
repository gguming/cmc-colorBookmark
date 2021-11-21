//
//  CalenderViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/05.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
import Alamofire

class CalenderViewController: UIViewController {
    var calendarData = [CalendarResult]()
    
    lazy var dataManager: CalenderDataManager = CalenderDataManager()
    var constantMonth = 0
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PrevButtonTapped(_ sender: Any) {
        constantMonth -= 1
        print("컨스턴트먼쓰-")
        print(constantMonth)
        
        let calenderInput: Parameters = ["page" : constantMonth]
        dataManager.getCalenderMonth(calenderInput, delegate: self)
        
        components.month = components.month! - 1
        self.calculation()
        self.CalenderCollectionview.reloadData()
        let firstDayOfMonth = cal.date(from: components)
 
    }
    
    @IBAction func NextButtonTapped(_ sender: Any) {
        constantMonth += 1
        print("컨스턴트먼쓰+")
        print(constantMonth)
        let calenderInput: Parameters = ["page" : constantMonth]
        dataManager.getCalenderMonth(calenderInput, delegate: self)
        
        let firstDayOfMonth = cal.date(from: components)
        components.month = components.month! + 1
        self.calculation()
        self.CalenderCollectionview.reloadData()
        
       // let firstDay = cal.date(from: components+1)
        let currentDate = dateFormatter.string(from: firstDayOfMonth!)
        let firstIndex = currentDate.index(of:".") ?? currentDate.endIndex
        let secondIndex: String.Index = currentDate.index(firstIndex, offsetBy: 1)
        
        let currentYear = String(currentDate[..<firstIndex])
        let currentMonth = String(currentDate[secondIndex...])
        print("bbbb")
        print(currentYear)
        if Int(exactly: cal.component(.year, from: now))! < Int(currentYear)! {

        }
        
//        MARK: API 연결시 사용
//        print(dateFormatter.string(from: firstDayOfMonth!) + ".1")
        
    }
    
    @IBOutlet weak var NextButtonImage: UIImageView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var CalenderLabel: UILabel!
    @IBOutlet weak var CalenderCollectionview: UICollectionView!
  
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0
    let disabledColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
    
    let colorString: String = ""
    let color: UIColor = UIColor.white
    let colorName: String = ""
    
    private func initView() {
            self.initCollection()
            dateFormatter.dateFormat = "yyyy.M"
            components.year = cal.component(.year, from: now)
            components.month = cal.component(.month, from: now)
            components.day = 1
            self.calculation()
        }
    
    private func calculation() {
        let firstDayOfMonth = cal.date(from: components)
        print("실험")
        print(dateFormatter.string(from: firstDayOfMonth!) + ".1")
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        CalenderLabel.text = dateFormatter.string(from: firstDayOfMonth!)
        
        self.days.removeAll()
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
        
        let currentDate = dateFormatter.string(from: firstDayOfMonth!)
        let firstIndex = currentDate.index(of:".") ?? currentDate.endIndex
        let currentYear = currentDate[..<firstIndex]
        let secondIndex: String.Index = currentDate.index(firstIndex, offsetBy: 1)
        let currentMonth = String(currentDate[secondIndex...])
       
        print("YEAR")
        print(currentYear)
        print("MONTH")
        print(currentMonth)
        }
    
    private func initCollection() {
          self.CalenderCollectionview.delegate = self
          self.CalenderCollectionview.dataSource = self
          self.CalenderCollectionview.register(UINib(nibName: "CalenderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalenderCollectionViewCell")
    }
    
    override func viewDidLoad() {
        constantMonth = 0
        let calenderInput: Parameters = ["page" : constantMonth]
        dataManager.getCalenderMonth(calenderInput, delegate: self)
        print(cal.component(.month, from: now) )
        self.view.layer.cornerRadius = 30
        TopView.layer.cornerRadius = 30
        super.viewDidLoad()
        self.initView()
    }
}


extension CalenderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
              case 0:
                  return 7
            
              default:
            return days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CalenderCollectionview.dequeueReusableCell(withReuseIdentifier: "CalenderCollectionViewCell", for: indexPath) as! CalenderCollectionViewCell
        
        cell.backgroundColor = .blue
        
        switch indexPath.section {
               case 0:
            cell.CircleImage.isHidden = true
            cell.DateLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.DateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            cell.DateLabel.textAlignment = .center
            cell.DateLabel.text = weeks[indexPath.row]
            
               default:
            //MARK: check
            
//            if calendarData[indexPath.row+1].color == nil {
//                cell.CircleImage.isHidden = true
//            }
//
//            else {
//                let circleColor = UIColor(hex: CalendarInfo.shared.calenderColor[indexPath.row])
//                cell.CircleImage.isHidden = false
//                cell.CircleImage.tintColor = circleColor
//            }
            
            //print(indexPath.row)
          //  print(calendarData[])
//            if CalendarInfo.shared.calenderColor[indexPath.row] == "nil" {
//                cell.CircleImage.isHidden = true
//            }
//            else {
//                let circleColor = UIColor(hex: CalendarInfo.shared.calenderColor[indexPath.row])
//                cell.CircleImage.isHidden = false
//                cell.CircleImage.tintColor = circleColor
//            }
            
            cell.CircleImage.isHidden = false
            cell.DateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            cell.DateLabel.textAlignment = .center
            cell.DateLabel.text = days[indexPath.row]
            
            if cell.DateLabel.text == "" {
                cell.CircleImage.isHidden = true
            }

               }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = CalenderCollectionview.cellForItem(at: indexPath) as? CalenderCollectionViewCell{
            cell.CircleImage.tintColor = .brown
        }
        
        let cell = CalenderCollectionview.dequeueReusableCell(withReuseIdentifier: "CalenderCollectionViewCell", for: indexPath) as! CalenderCollectionViewCell
        cell.CircleImage.tintColor = .brown
        print("cell SELECTED")
        print(days[indexPath.row])
        
//        cell.CircleImage.isHidden = true
//        cell.backgroundColor = UIColor.mainPink
        
        //self.CalenderCollectionview.reloadData()
        //print(CalendarInfo.shared.calenderDate[indexPath.row])
    }
    
}

extension CalenderViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
        let cellSize : CGFloat = myBoundSize / 9 - 5
        if indexPath.section == 0 {
            return CGSize(width: cellSize, height: cellSize)
        }
        
        return CGSize(width: cellSize, height: cellSize * 1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 15
        }
        
        if section == 1 {
            return 10
        }
        
       return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension CalenderViewController {
    func getCalenderSuccess(data: [CalendarResult]) {
        calendarData = data
        print("데이터 개수 ")
        print(calendarData.count)
        print(calendarData[0])
        print(calendarData[17].color)
        print(calendarData[18].color)
        CalenderCollectionview.reloadData()
    }
}
