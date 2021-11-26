//
//  MiniCodeViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/22.
//

import UIKit

class MiniCodeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    lazy var dataManager: ChangeSettingDataManager = ChangeSettingDataManager()
    
    let numberValue: Array<Int> = [1,2,3,4,5,6,7,8,9]
    var MiniCodeValue: Array<String> = []
    
    @IBOutlet weak var minicode_1: UIImageView!
    
    @IBOutlet weak var minicode_2: UIImageView!
    
    @IBOutlet weak var minicode_3: UIImageView!
    
    @IBOutlet weak var minicode_4: UIImageView!
    
    
    @IBOutlet weak var MiniCodeCollectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var MiniCodeCollectionview: UICollectionView!
    
    @IBAction func BackToSettingVC(_ sender: Any) {
        dismiss(animated: true, completion: {Constant.setting_1 = "N"})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MiniCodeCollectionview.delegate = self
        MiniCodeCollectionview.dataSource = self
        
//        let leadingValue = view.frame.width * 0.075
//        MiniCodeCollectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingValue).isActive = true
//
//        let height = MiniCodeCollectionview.collectionViewLayout.collectionViewContentSize.height
//        MiniCodeCollectionviewHeight.constant = height
//        self.view.setNeedsLayout()
 
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
        let cell = MiniCodeCollectionview.dequeueReusableCell(withReuseIdentifier: "MiniCodeCollectionViewCell", for: indexPath) as! MiniCodeCollectionViewCell
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
        
        print("CHECK")
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
        let cellWidth = MiniCodeCollectionview.bounds.width/3 - 6
        let cellHeight = cellWidth * 1/2.5
        return CGSize(width: cellWidth, height: cellHeight)
    }

}

extension MiniCodeViewController {
    func passwordEnd() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MiniCodeCheckViewController") as? MiniCodeCheckViewController
        vc?.MiniCode = MiniCodeValue
        vc!.modalPresentationStyle = .fullScreen
        present(vc!, animated: true, completion: nil)
    }
}
