//
//  SettingRequest.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/23.
//

import Foundation

//MARK: Delete NameStatus
struct SettingRequest: Encodable {
    var alarmStatus: String?
    var miniCodeStatus: String?
    var NameStatus: String?
    var BGMStatus: String?
}
