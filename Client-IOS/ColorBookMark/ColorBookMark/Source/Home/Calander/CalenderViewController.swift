//
//  CalenderViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/05.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
import Alamofire
import FloatingPanel

protocol SelectedCalendarDelegate: AnyObject {
    func makeNewDiary(date: String)
}

class CalenderViewController: UIViewController {
    var calendarData: [CalendarResult]?
    var bookmarks: [BookMarks]?
    weak var selectedDelegate: SelectedCalendarDelegate?
    
    lazy var calendarDataManager: CalenderDataManager = CalenderDataManager()
    lazy var calendarLimitDataManager: CalenderLimitDataManager = CalenderLimitDataManager()
    lazy var bookmarkDataManager: BookMarkDataManager = BookMarkDataManager()
    
    var constantMonth = 0
    var CalendarViewMonth = 0
    var startDate = 0
    var min = 0
    var max = 0
    var filledIndex = 0
    var filled = [Int]()
    var testArray = [Int](repeating: 0, count: 31)
    var date: String?
    
    func hexStringToUIColor (hex:String) -> UIColor {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }

            if ((cString.count) != 6) {
                return UIColor.gray
            }

            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    
    @IBOutlet weak var PrevButtonImage: UIImageView!
    @IBOutlet weak var PrevButton: UIButton!
    @IBAction func CancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PrevButtonTapped(_ sender: Any) {
        constantMonth -= 1
        print(constantMonth)
        
        let calenderInput: Parameters = ["page" : constantMonth]
        components.month = components.month! - 1
        self.calculation()
        
        NextButton.isEnabled = true
        NextButtonImage.tintColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        
        if min >= constantMonth {
            PrevButton.isEnabled = false
            PrevButtonImage.tintColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
        }
        testArray = [Int](repeating: 0, count: 31)
        filledIndex = 0
        calendarDataManager.getCalenderMonth(calenderInput, delegate: self)
        bookmarkDataManager.getBookMarkInCalendar(date: date ?? "2021-12", delegate: self)
    }
    
    @IBAction func NextButtonTapped(_ sender: Any) {
        constantMonth += 1
        print(constantMonth)
        let calenderInput: Parameters = ["page" : constantMonth]
        components.month = components.month! + 1
        self.calculation()
        
        PrevButton.isEnabled = true
        PrevButtonImage.tintColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        
        if max <= constantMonth {
            NextButton.isEnabled = false
            NextButtonImage.tintColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
        }
        testArray = [Int](repeating: 0, count: 31)
        filledIndex = 0
        calendarDataManager.getCalenderMonth(calenderInput, delegate: self)
        bookmarkDataManager.getBookMarkInCalendar(date: date ?? "2021-12", delegate: self)
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
        print(dateFormatter.string(from: firstDayOfMonth!) + ".1")
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
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
        var currentMonth = String(currentDate[secondIndex...])
        
        if currentMonth.count == 1 {
            currentMonth = "0\(currentMonth)"
        }
        date = "\(currentYear)-\(currentMonth)"
    
    }
    
    private func initCollection() {
          self.CalenderCollectionview.delegate = self
          self.CalenderCollectionview.dataSource = self
          self.CalenderCollectionview.register(UINib(nibName: "CalenderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalenderCollectionViewCell")
    }
    
    override func viewDidLoad() {
        calendarLimitDataManager.getCalenderLimit(delegate: self)
        constantMonth = 0
        let calenderInput: Parameters = ["page" : constantMonth]
        calendarDataManager.getCalenderMonth(calenderInput, delegate: self)
        print(cal.component(.month, from: now) )
        self.view.layer.cornerRadius = 30
        TopView.layer.cornerRadius = 30
        super.viewDidLoad()
        self.initView()
        bookmarkDataManager.getBookMarkInCalendar(date: date ?? "2021-12", delegate: self)
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
            cell.DateLabel.text = weeks[indexPath.item]
            cell.DateLabel.textColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
            
        default:
            cell.backgroundColor = .white
            
            if indexPath.item >= startDate && indexPath.item < CalendarViewMonth + startDate {
                if calendarData?[indexPath.item - startDate].color == nil {
                    cell.CircleImage.tintColor = .clear
                    cell.DateLabel.textColor = #colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)
                    filled.append(filledIndex)
                }
                else {
                    let CircleColor = calendarData?[indexPath.item - startDate].color! ?? "#000000"
                    print(CircleColor)
                    let CircleUIColor = hexStringToUIColor(hex: CircleColor)
                    filled.append(filledIndex)
                    testArray[indexPath.item - startDate] = filledIndex
                    filledIndex += 1
                    cell.CircleImage.tintColor = CircleUIColor
                    cell.DateLabel.textColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
                }
            }
            else {
                cell.CircleImage.tintColor = .clear
                cell.DateLabel.textColor = #colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)
            }
            
            cell.CircleImage.isHidden = false
            cell.DateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            cell.DateLabel.textAlignment = .center
            cell.DateLabel.text = days[indexPath.item]
            
            if cell.DateLabel.text == "" {
                cell.CircleImage.isHidden = true
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item >= startDate && indexPath.item < CalendarViewMonth + startDate {
            if calendarData?[indexPath.item - startDate].color != nil {
                let testIndex = testArray[indexPath.item - startDate]
                print("테스트 인덱스")
                print(testIndex)
                
                let storyboard = UIStoryboard(name: "BookMark", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "BookmarkDetailViewController") as? BookmarkDetailViewController else {return}
                
                vc.modalPresentationStyle = .fullScreen
                vc.diaryId = bookmarks?[testIndex].selectMonthDiary?.diaryView?.diaryId
                vc.date = bookmarks?[testIndex].selectMonthDiary?.diaryView?.date
                vc.index = testIndex - 1
                vc.view.backgroundColor = UIColor.white

                guard let pvc = self.presentingViewController else { return }
                self.dismiss(animated: true) {
                    pvc.present(vc, animated: false, completion: nil)
                }
            }
//            else {
//                let selectedDate = calendarData?[indexPath.item - startDate].date
//                let dateResult = selectedDate!.replacingOccurrences(of: "-", with: ".")
//                let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                guard let HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {return}
////                HomeVC.selectedDelegate = self
//                selectedDelegate?.makeNewDiary(date: dateResult)
//                dismiss(animated: false, completion: nil)
//            }
        }
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
        CalenderCollectionview.reloadData()
    }
    
    func didSuccessGetBookMarkInCalendar(_ result: GetBookMarkResponse) {
        print("------>\(result)")
        bookmarks = result.result
    }
    
    func failedToGetBookMarkInCalendar(message: String) {
        print("------>>>>\(message)")
        
    }
}
