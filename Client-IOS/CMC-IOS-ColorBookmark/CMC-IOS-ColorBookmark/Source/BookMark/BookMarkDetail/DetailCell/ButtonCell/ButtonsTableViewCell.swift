//
//  ButtonsTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/19.
//

import UIKit

class ButtonsTableViewCell: UITableViewCell {

    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var trashBtn: UIButton!
    
    @IBAction func editBtnTapped(_ sender: Any) {
    }
    @IBAction func trashBtnTapped(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editBtn.layer.cornerRadius = 8
        editBtn.clipsToBounds = true
        trashBtn.layer.cornerRadius = 8
        trashBtn.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
