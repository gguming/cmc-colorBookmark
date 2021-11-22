//
//  MiniCodeViewController.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/22.
//

import UIKit

class MiniCodeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let numberValue: Array<Int> = [1,2,3,4,5,6,7,8,9]
    var MiniCodeValue: Array<String> = []
    
    @IBOutlet weak var MiniCodeCollectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var MiniCodeCollectionview: UICollectionView!
    
    
    @IBOutlet weak var minicode_1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MiniCodeCollectionview.delegate = self
        MiniCodeCollectionview.dataSource = self
        
        let height = MiniCodeCollectionview.collectionViewLayout.collectionViewContentSize.height
        MiniCodeCollectionviewHeight.constant = height
        self.view.setNeedsLayout()
        
        minicode_1.layer.cornerRadius = 50
        minicode()
 
    }
    
    func minicode() {
        if MiniCodeValue.isEmpty {
            minicode_1.backgroundColor = .white
        }
        else{
            
            minicode_1.backgroundColor = .black
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
            cell.NumberLabel.text = String( 1 + indexPath.row)
        case 1:
            cell.NumberLabel.text = String( 4 + indexPath.row)
        case 2:
            cell.NumberLabel.text = String( 7 + indexPath.row)
        case 3:
            if indexPath.row == 0 {
                cell.isHidden = true
            }
            if indexPath.row == 1 {
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
        let cell = MiniCodeCollectionview.dequeueReusableCell(withReuseIdentifier: "MiniCodeCollectionViewCell", for: indexPath) as! MiniCodeCollectionViewCell
        
        switch indexPath.section {
        case 0:
            MiniCodeValue.append(String(1 + indexPath.row))
            print(MiniCodeValue)
        case 1:
            MiniCodeValue.append(String(4 + indexPath.row))
            print(MiniCodeValue)
        case 2:
            MiniCodeValue.append(String(7 + indexPath.row))
            print(MiniCodeValue)
        default:
            if indexPath.row == 1 {
                MiniCodeValue.append(String(0))
                print(MiniCodeValue)
            }
            if indexPath.row == 2 {
                if MiniCodeValue.isEmpty == false {
                    MiniCodeValue.removeLast()
                }
                print(MiniCodeValue)
            }
        }
        minicode()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = MiniCodeCollectionview.frame.size.width / 3 - 6
        let cellHeight = cellWidth * 1/2
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
