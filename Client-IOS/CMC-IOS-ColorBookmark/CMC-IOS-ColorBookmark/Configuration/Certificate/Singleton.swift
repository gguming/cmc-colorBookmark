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
    private init() { }
}
