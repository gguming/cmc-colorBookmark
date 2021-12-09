//
//  CalenderResponse.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/15.
//

import Foundation

struct CalendarResponse: Decodable{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [CalendarResult]
}

struct CalendarResult: Decodable {
    let date: String
    let color: String?
    let colorName: String?
}



