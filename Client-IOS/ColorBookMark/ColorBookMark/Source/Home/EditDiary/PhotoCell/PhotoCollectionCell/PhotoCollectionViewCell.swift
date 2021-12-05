//
//  PhotoCollectionViewCell.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/24.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBAction func deleteBtnTapped(_ sender: Any) {
        deleteBtnDelegate?.deleteBtn(index: self.index ?? 1)
    }
    
    @IBOutlet weak var img: UIImageView!
    var deleteBtnDelegate: DeleteBtnDelegate?
    var index: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
    }

}

protocol DeleteBtnDelegate{
    func deleteBtn(index: Int)
}

