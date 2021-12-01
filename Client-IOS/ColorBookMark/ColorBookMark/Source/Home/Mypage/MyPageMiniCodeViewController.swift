//
//  MyPageMiniCodeViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/27.
//

import UIKit
import Foundation
import AudioToolbox

class MyPageMiniCodeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let numberValue: Array<Int> = [1,2,3,4,5,6,7,8,9]
    var MiniCodeValue: Array<String> = []
    var MiniCodeCheckValue: Array<String> = []
    
    @IBOutlet weak var minicode_1: UIImageView!
    @IBOutlet weak var minicode_2: UIImageView!
    @IBOutlet weak var minicode_3: UIImageView!
    @IBOutlet weak var minicode_4: UIImageView!
    @IBOutlet weak var MypageMiniCodeCollectionview: UICollectionView!
    
    @IBAction func BackToMypageVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MypageMiniCodeCollectionview.delegate = self
        MypageMiniCodeCollectionview.dataSource = self
        let miniCode = Constant.miniCode!
        MiniCodeCheckValue = miniCode.map { String($0) }
    }
    
    func minicode() {
        switch MiniCodeValue.count {
            
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
            passwordEnd()
            
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
        let cell = MypageMiniCodeCollectionview.dequeueReusableCell(withReuseIdentifier: "MypageMiniCodeCollectionViewCell", for: indexPath) as! MypageMiniCodeCollectionViewCell
        
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

        switch indexPath.section {
        case 0:
            MiniCodeValue.append(String(1 + indexPath.item))
            print(MiniCodeValue)
        case 1:
            MiniCodeValue.append(String(4 + indexPath.item))
            print(MiniCodeValue)
        case 2:
            MiniCodeValue.append(String(7 + indexPath.item))
            print(MiniCodeValue)
        default:
            if indexPath.item == 1 {
                MiniCodeValue.append(String(0))
                print(MiniCodeValue)
            }
            if indexPath.item == 2 {
                if MiniCodeValue.isEmpty == false {
                    MiniCodeValue.removeLast()
                }
                print(MiniCodeValue)
            }
        }
        minicode()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = MypageMiniCodeCollectionview.frame.width/3 - 6
        let cellHeight = cellWidth * 1/2.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension MyPageMiniCodeViewController {
    func passwordEnd() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            if MiniCodeCheckValue == MiniCodeValue {
                let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ChangeNicknameViewController")
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
            else {
               AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                MiniCodeValue.removeAll()
                minicode_1.image = UIImage(named: "101")
                minicode_2.image = UIImage(named: "101")
                minicode_3.image = UIImage(named: "101")
                minicode_4.image = UIImage(named: "101")
            }
        }
    }
}
