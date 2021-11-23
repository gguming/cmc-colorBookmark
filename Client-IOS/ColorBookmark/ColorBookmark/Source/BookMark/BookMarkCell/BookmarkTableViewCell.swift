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
    
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    func setupLayout() {
        
    }
    
    
    
}
