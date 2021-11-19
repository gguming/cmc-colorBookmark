//
//  BookmarkTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/19.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var firstItem: UIImageView!
    @IBOutlet weak var secondItem: UIImageView!
    @IBOutlet weak var thirdItem: UIImageView!
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12.0, left: 0, bottom: 12, right: 0))
    }
    
    func setupLayout() {
        
    }
    
    
    
}
