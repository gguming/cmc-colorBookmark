//
//  SettingTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/13.
//

import UIKit

protocol PresentVCDelegate: AnyObject {
    
    func presentMiniCodeVC()
}

class SettingTableViewCell: UITableViewCell {

    weak var cellDelegate: PresentVCDelegate?
    
    var cellNumber: Int? = nil
    var onOff = "OFF"
    var switchOnBoolean = false
    let pinkColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0.5725490196, alpha: 1)
    let grayColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
    let boldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    @IBAction func SettingSwitchTapped(_ sender: Any) {
        if SettingSwitch.isOn {
            onOff = "ON"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: pinkColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            OnoffLabel.attributedText = onOffString
            switchOnBoolean = true
            SettingInfo.shared.settingOnOff[cellNumber!] = true
            print(SettingInfo.shared.settingOnOff)
            settingAction(cellNum: cellNumber!)
        }
        else {
            onOff = "OFF"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: grayColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            OnoffLabel.attributedText = onOffString
            switchOnBoolean = false
            print(cellNumber)
            SettingInfo.shared.settingOnOff[cellNumber!] = false
            print(SettingInfo.shared.settingOnOff)

        }
    }
    
    @IBOutlet weak var OnoffLabel: UILabel!
    @IBOutlet weak var SettingSwitch: UISwitch!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var Cellview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Cellview.layer.cornerRadius = 12
        self.layer.cornerRadius = 12
        
        SettingSwitch.isOn = false
        TitleLabel.sizeToFit()
        OnoffLabel.sizeToFit()
        TitleLabel.adjustsFontSizeToFitWidth = true
        TitleLabel.minimumScaleFactor = 0.5
       
        let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: grayColor, .font: boldFont]
        let onOffString = NSMutableAttributedString()
        onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
        OnoffLabel.attributedText = onOffString
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SettingTableViewCell {
    func settingAction(cellNum: Int) {
        switch cellNum {
        case 0:
            print("알림 ON")
        case 1:
            print("암호 ON")
            cellDelegate?.presentMiniCodeVC()
            
           
            
        case 2:
            print("배경음악 ON")
        default:
            break
        }
    }
}
