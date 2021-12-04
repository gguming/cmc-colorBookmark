//
//  PatchColorResponse.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/05.
//

import Foundation

struct PatchColorResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
