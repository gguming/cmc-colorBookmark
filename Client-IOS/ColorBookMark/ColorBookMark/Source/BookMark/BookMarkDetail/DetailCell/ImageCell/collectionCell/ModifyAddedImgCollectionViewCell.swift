//
//  ModifyAddedImgCollectionViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/12.
//

import UIKit

class ModifyAddedImgCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    var index: Int?
    var delegate: DeleteModifyImg?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteBtnTapped(_ sender: Any) {
        delegate?.deleteModifyImg(index: index ?? 0)
    }
}

protocol DeleteModifyImg{
    func deleteModifyImg(index: Int)
}
