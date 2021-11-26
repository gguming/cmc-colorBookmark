//
//  PhotoTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/10.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    var delegate: AddPhotoInEmptyDelegate?
    @IBAction func addPhotoTapped(_ sender: Any) {
        delegate?.addPhotoInEmpty()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol AddPhotoInEmptyDelegate {
    func addPhotoInEmpty()
}
