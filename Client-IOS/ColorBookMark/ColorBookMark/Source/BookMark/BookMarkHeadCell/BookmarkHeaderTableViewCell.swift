//
//  BookmarkHeaderTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/03.
//

import UIKit

class BookmarkHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var bookmarkCountInfoLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var archiveBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func buttonUI() {
        archiveBtn.setTitle("감정 아카이브", for: .normal)
        archiveBtn.titleLabel?.font = .systemFont(ofSize: 11)
        archiveBtn.setImage(UIImage(named: "iconMaterialPanoramaHorizontal.png"), for: .normal)
        
        archiveBtn.alignTextBelow(spacing: 6)
    }
    
    
    
    
    
}
