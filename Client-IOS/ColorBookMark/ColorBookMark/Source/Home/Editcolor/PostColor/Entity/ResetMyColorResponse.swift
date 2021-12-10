//
//  ResetMyColorResponse.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/10.
//

import Foundation

struct ResetMyColorResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String?
}
