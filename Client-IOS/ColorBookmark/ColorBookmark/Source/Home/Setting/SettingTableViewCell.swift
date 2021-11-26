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
    lazy var dataManager: SettingDataManager = SettingDataManager()
    weak var cellDelegate: PresentVCDelegate?
    
    var cellNumber: Int? = nil
    var onOff = "OFF"
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
            saveYesInUserdefaults()
            settingAction(cellNum: cellNumber!)
        }
        
        else {
            onOff = "OFF"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: grayColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            OnoffLabel.attributedText = onOffString
            saveNoInUserdefaults()
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
        
        TitleLabel.sizeToFit()
        OnoffLabel.sizeToFit()
        TitleLabel.adjustsFontSizeToFitWidth = true
        TitleLabel.minimumScaleFactor = 0.5
        
        if SettingSwitch.isOn {
            print("켜져있음")
            onOff = "ON"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: pinkColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            OnoffLabel.attributedText = onOffString
            saveYesInUserdefaults()
        }
        
        else {
            print("꺼져있음")
            onOff = "OFF"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: grayColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            OnoffLabel.attributedText = onOffString
            saveNoInUserdefaults()

        }
        
    }
    
    func saveYesInUserdefaults() {
        switch cellNumber {
        case 0:
            Constant.setting_0 = "Y"
        case 1:
            Constant.setting_1 = "Y"
        case 2:
            Constant.setting_2 = "Y"
        default:
            break
        }
    }
    
    func saveNoInUserdefaults() {
        switch cellNumber {
        case 0:
            Constant.setting_0 = "N"
        case 1:
            Constant.setting_1 = "N"
        case 2:
            Constant.setting_2 = "N"
        default:
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension SettingTableViewCell {
    func settingAction(cellNum: Int) {
        switch cellNum {
        case 0:
            print("알림 ON")
            let settingInput = SettingRequest(alarmStatus: "Y")
            dataManager.getSettingValue(settingInput, delegate: self)
        case 1:
            print("암호 ON")
            let settingInput = SettingRequest(miniCodeStatus: "Y")
            dataManager.getSettingValue(settingInput, delegate: self)
            cellDelegate?.presentMiniCodeVC()
       
        case 2:
            print("배경음악 ON")
            let settingInput = SettingRequest(BGMStatus: "Y")
            dataManager.getSettingValue(settingInput, delegate: self)
        default:
            break
        }
    }
}
