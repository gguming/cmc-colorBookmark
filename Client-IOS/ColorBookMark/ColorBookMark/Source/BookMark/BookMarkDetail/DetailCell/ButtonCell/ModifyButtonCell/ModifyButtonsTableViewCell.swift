//
//  ModifyButtonsTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/06.
//

import UIKit

class ModifyButtonsTableViewCell: UITableViewCell {

    var doneDelegate: ModifyModeDelegate?
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        doneDelegate?.doneModifytMode()
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