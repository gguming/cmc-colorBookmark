//
//  HeaderTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/10.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    var delegate: EditBtnDelegate?
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var xBtn: UIButton!
   
    @IBOutlet weak var seperateLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        infoLabel.textColor = .black
        xBtn.tintColor = .black
    }
    
}

protocol EditBtnDelegate {
    func presentEditVC()
}

//extension HeaderTableViewCell: ChangeStateDelegate{
//    func changeState() {
//        self.checkState()
//    }
//    
//    
//}
