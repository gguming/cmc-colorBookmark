//
//  StoryHaveTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/03.
//

import UIKit

class StoryHaveTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.delegate = self
        textView.isEditable = false
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension StoryHaveTableViewCell: UITextViewDelegate {
//    func textViewDidEndEditing(_ textView: UITextView) {
//
//    }
    func textViewDidChange(_ textView: UITextView) {
        let modifyInfo = ModifyDetailInfo.shared
        modifyInfo.text = textView.text
        print(modifyInfo.text)
    }
}
