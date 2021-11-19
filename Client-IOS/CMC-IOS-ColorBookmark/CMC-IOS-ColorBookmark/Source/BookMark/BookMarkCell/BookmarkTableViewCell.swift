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
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    func setupLayout() {
        
    }
    
    
    
}
