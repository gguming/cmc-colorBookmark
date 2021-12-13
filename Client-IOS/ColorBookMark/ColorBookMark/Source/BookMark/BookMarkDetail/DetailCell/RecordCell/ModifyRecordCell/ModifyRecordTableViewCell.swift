//
//  ModifyRecordTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/03.
//

import UIKit

class ModifyRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
