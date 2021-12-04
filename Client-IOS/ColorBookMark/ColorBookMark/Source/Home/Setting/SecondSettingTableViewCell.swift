//
//  SecondSettingTableViewCell.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/27.
//

import UIKit

class SecondSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var SecondCellview: UIView!
    @IBOutlet weak var SecondSettingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        SecondCellview.layer.cornerRadius = 12
        self.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
}
