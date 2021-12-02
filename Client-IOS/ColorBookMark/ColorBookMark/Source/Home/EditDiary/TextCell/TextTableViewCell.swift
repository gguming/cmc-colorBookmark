//
//  TextTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/10.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    let placeHolder = "글을 입력해 주세요"
    let recordInfo = RecordInfo.shared
    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        textView.text = placeHolder
        if textView.text == placeHolder {
            recordInfo.text = ""
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TextTableViewCell: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder {
            recordInfo.text = ""
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolder
            recordInfo.text = ""
        }
        recordInfo.text = textView.text
    }
}
