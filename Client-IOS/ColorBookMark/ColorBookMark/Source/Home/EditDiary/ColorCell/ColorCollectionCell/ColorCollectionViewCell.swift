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
    
    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var view_2: UIView!
    @IBOutlet weak var view_3: UIView!
    @IBOutlet weak var deleteButton: UIImageView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_1.isHidden = true
        view_2.isHidden = true
        view_3.isHidden = true
        deleteButton.isHidden = true
       
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                colorView.isHidden = true
                view_1.isHidden = false
                view_2.isHidden = false
                view_3.isHidden = false
                view_1.backgroundColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0.4352941176, alpha: 1)
                view_2.backgroundColor = UIColor.white
                view_3.backgroundColor = colorView.backgroundColor
                view_1.layer.cornerRadius = view_1.frame.width/2
                view_2.layer.cornerRadius = view_2.frame.width/2
                view_3.layer.cornerRadius = view_3.frame.width/2
            }
            
            else {
                colorView.isHidden = false
                view_1.isHidden = true
                view_2.isHidden = true
                view_3.isHidden = true
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
//        backView.isHidden = true
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
