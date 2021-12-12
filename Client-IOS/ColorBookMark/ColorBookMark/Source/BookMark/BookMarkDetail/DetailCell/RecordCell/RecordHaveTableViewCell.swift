//
//  RecordHaveTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/03.
//

import UIKit

class RecordHaveTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    var record: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
