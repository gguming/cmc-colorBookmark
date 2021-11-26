//
//  SecondSettingTableViewCell.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/26.
//

import UIKit

class SecondSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var SecondCellView: UIView!
    @IBOutlet weak var SecondSettingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.translatesAutoresizingMaskIntoConstraints = false
        SecondCellView.layer.cornerRadius = 12
        self.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
