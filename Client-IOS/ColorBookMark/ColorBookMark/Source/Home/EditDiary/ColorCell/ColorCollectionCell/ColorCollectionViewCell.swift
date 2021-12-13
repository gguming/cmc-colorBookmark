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
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var deleteButton: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.isHidden = true
        deleteButton.isHidden = true
        selectedView.isHidden = true
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedView.isHidden = false
                backView.isHidden = false
                
                colorView.backgroundColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0.4352941176, alpha: 1)
                backView.layer.cornerRadius = 50
                backView.backgroundColor = UIColor.white
                selectedView.layer.cornerRadius = 50

            }
            else {
                backView.isHidden = true
                selectedView.isHidden = true
            }
        }
    }
    
    @objc func EditColorCircle() {
        self.colorDelegate?.selectedColorCircle(index: index)
    }
    
    @objc func EditColorName() {
        self.colorDelegate?.selectedColorName(index: index)
    }
    
    @objc func DeleteColor() {
        self.colorDelegate?.selectedColorDelete(index: index)
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
        
        let tapGesture_3 = UITapGestureRecognizer(target: self, action: #selector(DeleteColor))
        deleteButton.addGestureRecognizer(tapGesture_3)
        deleteButton.isUserInteractionEnabled = true
    }

}
