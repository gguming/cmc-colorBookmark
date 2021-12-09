//
//  CalenderLimitResponse.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/10.
//

import Foundation

struct CalenderLimitResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [CalendarLimitResult]
}

struct CalendarLimitResult: Decodable {
    var min: Int
    var max: Int
}
