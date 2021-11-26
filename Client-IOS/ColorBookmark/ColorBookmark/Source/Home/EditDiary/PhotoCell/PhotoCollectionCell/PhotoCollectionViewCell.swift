//
//  PhotoCollectionViewCell.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/24.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
    }

}
