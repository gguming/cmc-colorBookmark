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
    var calendarData: [CalendarResult]?
    
    lazy var dataManager: CalenderDataManager = CalenderDataManager()
    var constantMonth = 0
    var CalendarViewMonth = 0
    var startDate = 0
    
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
//        let currentDate = dateFormatter.string(from: firstDayOfMonth!)
//        let firstIndex = currentDate.index(of:".") ?? currentDate.endIndex
//        let secondIndex: String.Index = currentDate.index(firstIndex, offsetBy: 1)
//
//        let currentYear = String(currentDate[..<firstIndex])
//        let currentMonth = String(currentDate[secondIndex...])
//        print("bbbb")
//        print(currentYear)
        
//        if Int(exactly: cal.component(.year, from: now))! < Int(currentYear)! {
//
//        }
        
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
        print("ZZZZZZ")
        print(daysCountInMonth)
        CalendarViewMonth = daysCountInMonth
        weekdayAdding = 2 - firstWeekday
        CalenderLabel.text = dateFormatter.string(from: firstDayOfMonth!)
        
        self.days.removeAll()
        startDate = 0
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                startDate += 1
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
        print("리리ㅣㄹ")
        print(startDate)
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
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = .white
            cell.CircleImage.isHidden = true
            cell.DateLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.DateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            cell.DateLabel.textAlignment = .center
            cell.DateLabel.text = weeks[indexPath.row]
            
        default:
            //MARK: check
            //끝일 30 or 31
            print(CalendarViewMonth, "끝일")
            // 달력에서 현재 row
            print(indexPath.row, "현재 row")
            cell.backgroundColor = .white
            let currentIndex = startDate + indexPath.row
            
            if indexPath.row > startDate - 1 && indexPath.row < CalendarViewMonth + startDate - 1 {
                print(currentIndex, "api에 넣는 인덱스값")
                print(indexPath.row - startDate, "+++")
                if calendarData?[indexPath.row - startDate].color == nil {
                    cell.CircleImage.tintColor = .clear
                }
                else {
                    let CircleColor = calendarData?[indexPath.row - startDate].color! ?? "#000000"
                    print(CircleColor)
                    cell.CircleImage.tintColor = UIColor(hex: CircleColor)
                }
            }
            else {
                cell.CircleImage.tintColor = .clear
            }
            
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
        print(calendarData?.count)
//        print(calendarData[0])
        print(calendarData?[17].color)
//        print(calendarData[18].color)
        CalenderCollectionview.reloadData()
    }
}
