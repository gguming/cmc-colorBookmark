//
//  PhotoBtnCollectionViewCell.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/24.
//

import UIKit

class PhotoBtnCollectionViewCell: UICollectionViewCell {
    var delegate: PhotoAddDelegate?
    @IBAction func addPhotoTapped(_ sender: Any) {
        delegate?.appendPhoto()
        print(111111)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

protocol PhotoAddDelegate {
    func appendPhoto()
}
