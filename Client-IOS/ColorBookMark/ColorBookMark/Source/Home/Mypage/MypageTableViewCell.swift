//
//  MypageTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/18.
//

import UIKit

class MypageTableViewCell: UITableViewCell {

    @IBOutlet weak var MypageView: UIView!
    @IBOutlet weak var MypageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
        MypageView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
