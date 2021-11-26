//
//  SecondSettingTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/19.
//

import UIKit

class SecondSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var SecondSettingTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
