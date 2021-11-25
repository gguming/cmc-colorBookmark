//
//  FindPasswordResponse.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/25.
//

import Foundation

struct FindPasswordResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
