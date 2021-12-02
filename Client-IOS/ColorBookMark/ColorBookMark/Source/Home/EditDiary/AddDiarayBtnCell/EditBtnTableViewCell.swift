//
//  EditBtnTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/12.
//

import UIKit

class EditBtnTableViewCell: UITableViewCell {
    var addDiaryDelegate: AddDiaryDelegate?
    @IBOutlet weak var editBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        editBtn.layer.cornerRadius = 14
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addDiaryBtnTapped(_ sender: Any) {
        addDiaryDelegate?.addDiary()
    }
    
}

protocol AddDiaryDelegate {
    func addDiary()
}
