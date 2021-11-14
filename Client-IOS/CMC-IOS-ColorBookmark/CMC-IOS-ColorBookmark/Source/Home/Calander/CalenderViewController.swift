//
//  CalenderViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/05.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
class CalenderViewController: UIViewController {
    
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var CalenderLabel: UILabel!
    @IBOutlet weak var CalenderCollectionview: UICollectionView!
  
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일
    
    private func initView() {
            self.initCollection()
            dateFormatter.dateFormat = "yyyy.M" // 월 표시 포맷 설정
            components.year = cal.component(.year, from: now)
            components.month = cal.component(.month, from: now)
            components.day = 1
            self.calculation()
        }
    private func calculation() { // 월 별 일 수 계산
            let firstDayOfMonth = cal.date(from: components)
            let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!) // 해당 수로 반환이 됩니다. 1은 일요일 ~ 7은 토요일
            daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
            weekdayAdding = 2 - firstWeekday
            CalenderLabel.text = dateFormatter.string(from: firstDayOfMonth!)
            self.days.removeAll()
            for day in weekdayAdding...daysCountInMonth {
                if day < 1 { // 1보다 작을 경우는 비워줘야 하기 때문에 빈 값을 넣어준다.
                    self.days.append("")
                } else {
                    self.days.append(String(day))
                }
            }
        }
    
    private func initCollection() {  // CollectionView의 초기 설정
          self.CalenderCollectionview.delegate = self
          self.CalenderCollectionview.dataSource = self
          self.CalenderCollectionview.register(UINib(nibName: "CalenderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalenderCollectionViewCell")
    }
    
    override func viewDidLoad() {
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
            cell.CircleImage.isHidden = true
            cell.DateLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.DateLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            cell.DateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            cell.DateLabel.textAlignment = .center
            cell.DateLabel.text = weeks[indexPath.row]
            
               default:
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
