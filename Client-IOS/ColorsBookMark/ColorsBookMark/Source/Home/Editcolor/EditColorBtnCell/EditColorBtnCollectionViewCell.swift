//
//  EditColorBtnCollectionViewCell.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/22.
//

import UIKit

class EditColorBtnCollectionViewCell: UICollectionViewCell {
    var delegate: ClickEditBtn?
    @IBAction func editBtnTapped(_ sender: Any) {
        
        delegate?.presentColorPicker()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

protocol ClickEditBtn{
    func presentColorPicker()
}
