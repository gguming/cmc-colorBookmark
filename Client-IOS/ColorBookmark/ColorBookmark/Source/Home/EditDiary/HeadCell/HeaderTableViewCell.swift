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
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var seperateLineView: UIView!
    @IBAction func editBtnTapped(_ sender: Any) {
//        let sb = UIStoryboard(name: "EditColor", bundle: nil)
//        guard let vc = sb.instantiateViewController(withIdentifier: "EditColorViewController") as? EditColorViewController else {return}
//        vc.modalPresentationStyle = .overCurrentContext
        
    }
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
        editBtn.layer.cornerRadius = 15
//        xBtn.backgroundColor = UIColor(red: 242, green: 242, blue: 242, alpha: 1)
//        seperateLineView.backgroundColor = UIColor(red: 112, green: 112, blue: 112, alpha: 1)
    }
    
    func checkState(){
        if Constant.panelState == 0 {
            editBtn.isHidden = false
            xBtn.isHidden = true
        } else {
            
            editBtn.isHidden = true
            xBtn.isHidden = false
        }
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
