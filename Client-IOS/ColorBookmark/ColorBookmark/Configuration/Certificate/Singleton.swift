//
//  Singleton.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/14.
//

import Foundation

class JwtInfo {
    static let shared = JwtInfo()
    var jwtValue: String?
    private init() { }
}

class CalendarInfo {
    static let shared = CalendarInfo()
    var calenderDate = [String]()
    var calenderColor = [String]()
    private init() { }
}

class SettingInfo {
    static let shared = SettingInfo()
    var settingOnOff: Array<Bool> = [false, false, false]
}

class MiniCodeInfo {
    static let shared = MiniCodeInfo()
    var miniCodeValue: String?
    private init() { }
}
