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
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
    }

}
