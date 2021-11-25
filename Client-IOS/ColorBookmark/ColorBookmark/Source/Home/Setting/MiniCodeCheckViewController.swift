//
//  MiniCodeCheckViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/23.
//

import UIKit
import Foundation
import AudioToolbox

class MiniCodeCheckViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var dataManager: MiniCodeDataManager = MiniCodeDataManager()
    
    let numberValue: Array<Int> = [1,2,3,4,5,6,7,8,9]
    var MiniCodeCheckValue: Array<String> = []
    var MiniCode: Array<String> = []
     
    
    @IBOutlet weak var minicode_1: UIImageView!
    @IBOutlet weak var minicode_2: UIImageView!
    @IBOutlet weak var minicode_3: UIImageView!
    @IBOutlet weak var minicode_4: UIImageView!
    
    @IBAction func BackToSettingVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var MiniCodeCheckCollectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var MiniCodeCheckCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        
        print(MiniCode)
        super.viewDidLoad()
        MiniCodeCheckCollectionview.delegate = self
        MiniCodeCheckCollectionview.dataSource = self
        
        let leadingValue = view.frame.width * 0.075
        MiniCodeCheckCollectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingValue).isActive = true
        
        let height = MiniCodeCheckCollectionview.collectionViewLayout.collectionViewContentSize.height
        MiniCodeCheckCollectionviewHeight.constant = height
        self.view.setNeedsLayout()
        
    }
    
    func minicode() {
        switch MiniCodeCheckValue.count {
            
        case 0:
            minicode_1.image = UIImage(named: "101")
            minicode_2.image = UIImage(named: "101")
            minicode_3.image = UIImage(named: "101")
            minicode_4.image = UIImage(named: "101")
            
        case 1:
            minicode_1.image = UIImage(named: "99")
            minicode_2.image = UIImage(named: "101")
            minicode_3.image = UIImage(named: "101")
            minicode_4.image = UIImage(named: "101")
            
        case 2:
            minicode_1.image = UIImage(named: "99")
            minicode_2.image = UIImage(named: "99")
            minicode_3.image = UIImage(named: "101")
            minicode_4.image = UIImage(named: "101")
            
        case 3:
            minicode_1.image = UIImage(named: "99")
            minicode_2.image = UIImage(named: "99")
            minicode_3.image = UIImage(named: "99")
            minicode_4.image = UIImage(named: "101")
            
        case 4:
            minicode_1.image = UIImage(named: "99")
            minicode_2.image = UIImage(named: "99")
            minicode_3.image = UIImage(named: "99")
            minicode_4.image = UIImage(named: "99")
            passwordCheckEnd()
        default:
            break
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MiniCodeCheckCollectionview.dequeueReusableCell(withReuseIdentifier: "MiniCodeCheckCollectionViewCell", for: indexPath) as! MiniCodeCheckCollectionViewCell
        
        cell.layer.cornerRadius = 7
        cell.backgroundColor = .white
        
        switch indexPath.section {
        case 0:
            cell.NumberLabel.text = String( 1 + indexPath.item)
        case 1:
            cell.NumberLabel.text = String( 4 + indexPath.item)
        case 2:
            cell.NumberLabel.text = String( 7 + indexPath.item)
        case 3:
            if indexPath.item == 0 {
                cell.isHidden = true
            }
            if indexPath.item == 1 {
                cell.NumberLabel.text = "0"
            }
            else {
                cell.backgroundColor = .clear
                let attributedString = NSMutableAttributedString()
                let imageAttachment = NSTextAttachment()
                imageAttachment.image = UIImage(named: "177")
                attributedString.append(NSAttributedString(attachment: imageAttachment))
                cell.NumberLabel.attributedText = attributedString

            }
        default:
            break
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = MiniCodeCheckCollectionview.dequeueReusableCell(withReuseIdentifier: "MiniCodeCheckCollectionViewCell", for: indexPath) as! MiniCodeCheckCollectionViewCell
        
        switch indexPath.section {
        case 0:
            MiniCodeCheckValue.append(String(1 + indexPath.item))
            print(MiniCodeCheckValue)
        case 1:
            MiniCodeCheckValue.append(String(4 + indexPath.item))
            print(MiniCodeCheckValue)
        case 2:
            MiniCodeCheckValue.append(String(7 + indexPath.item))
            print(MiniCodeCheckValue)
        default:
            if indexPath.item == 1 {
                MiniCodeCheckValue.append(String(0))
                print(MiniCodeCheckValue)
            }
            if indexPath.item == 2 {
                if MiniCodeCheckValue.isEmpty == false {
                    MiniCodeCheckValue.removeLast()
                }
                print(MiniCodeCheckValue)
            }
        }
        
        minicode()
     
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = MiniCodeCheckCollectionview.frame.size.width / 3 - 6
        let cellHeight = cellWidth * 1/2.5
        return CGSize(width: cellWidth, height: cellHeight)
    }

}

extension MiniCodeCheckViewController {
    func passwordCheckEnd() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            if MiniCodeCheckValue == MiniCode {
                let stringMiniCode = MiniCode.joined(separator: "")
                MiniCodeInfo.shared.miniCodeValue = stringMiniCode
                print(MiniCodeInfo.shared.miniCodeValue)
                let miniCodeInput = MiniCodeRequest(miniCode: stringMiniCode)
                dataManager.createMiniCode(miniCodeInput, delegate: self)
            }
            else {
               AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                MiniCodeCheckValue.removeAll()
                minicode_1.image = UIImage(named: "101")
                minicode_2.image = UIImage(named: "101")
                minicode_3.image = UIImage(named: "101")
                minicode_4.image = UIImage(named: "101")
            }
        }
    }
    
    func createMiniCodeSuccess() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        changeRootViewController(vc)
  
    }
}



