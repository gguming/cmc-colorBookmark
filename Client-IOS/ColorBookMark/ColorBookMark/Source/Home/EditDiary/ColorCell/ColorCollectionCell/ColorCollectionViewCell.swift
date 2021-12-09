//
//  ColorCollectionViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/10.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    weak var colorDelegate: ColorCollectionViewCellDelegate?
    var index: Int = 0
    var myColorId = 0
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.backgroundColor = .red
        backView.layer.cornerRadius = 45
        backView.isHidden = true
    }
    
    @objc func EditColorCircle() {
        print("#######")
        self.colorDelegate?.selectedColorCircle(index: index)
    }
    
    @objc func EditColorName() {
        self.colorDelegate?.selectedColorName(index: index)
    }
    
    
    func setUI() {
        colorView.layer.cornerRadius = 42
        colorView.clipsToBounds = true
    }
    
    func selectAni() {
//        colorView.layer.masksToBounds = true
        backView.isHidden = true
        self.isSelected = true
    }
    
    func setGesture() {
        let tapGesture_1 = UITapGestureRecognizer(target: self, action: #selector(EditColorCircle))
        colorView.addGestureRecognizer(tapGesture_1)
        colorView.isUserInteractionEnabled = true
        
        let tapGesture_2 = UITapGestureRecognizer(target: self, action: #selector(EditColorName))
        colorNameLabel.addGestureRecognizer(tapGesture_2)
        colorNameLabel.isUserInteractionEnabled = true
    }

}
