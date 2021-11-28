//
//  ColorCollectionViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/10.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    


    
    
    func setUI() {
        colorView.layer.cornerRadius = 42
        colorView.clipsToBounds = true
    }
    
    func selectAni() {
        colorView.layer.masksToBounds = true
        colorView.layer.borderWidth = 2
        colorView.layer.borderColor = UIColor(red: 255, green: 111, blue: 111, alpha: 1).cgColor
    }

}
