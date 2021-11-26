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
    var switchOnBoolean = false
    let pinkColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0.5725490196, alpha: 1)
    let grayColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
    let boldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    let SettingValue = ["setting_1", "setting_2", "setting_3"]
    
    @IBAction func SettingSwitchTapped(_ sender: Any) {
        
        if SettingSwitch.isOn {
            onOff = "ON"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: pinkColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            OnoffLabel.attributedText = onOffString
            switchOnBoolean = true
            UserDefaults.standard.set("Y", forKey: SettingValue[cellNumber!])
            print(SettingInfo.shared.settingOnOff)
            settingAction(cellNum: cellNumber!)
        }
        else {
            onOff = "OFF"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: grayColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            UserDefaults.standard.set("N", forKey: SettingValue[cellNumber!])
            OnoffLabel.attributedText = onOffString
            switchOnBoolean = false
            print(cellNumber)
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
        
        TitleLabel.sizeToFit()
        OnoffLabel.sizeToFit()
        TitleLabel.adjustsFontSizeToFitWidth = true
        TitleLabel.minimumScaleFactor = 0.5
       
//        let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: grayColor, .font: boldFont]
//        let onOffString = NSMutableAttributedString()
//        onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
//        OnoffLabel.attributedText = onOffString
        
        if SettingSwitch.isOn {
            print("켜져있음")
            onOff = "ON"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: pinkColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            OnoffLabel.attributedText = onOffString
            switchOnBoolean = true

        }
        else {
            print("꺼져있음")
            onOff = "OFF"
            let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: grayColor, .font: boldFont]
            let onOffString = NSMutableAttributedString()
            onOffString.append(NSAttributedString(string: onOff, attributes: generalAttributes))
            OnoffLabel.attributedText = onOffString
            switchOnBoolean = false

        }
        
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
