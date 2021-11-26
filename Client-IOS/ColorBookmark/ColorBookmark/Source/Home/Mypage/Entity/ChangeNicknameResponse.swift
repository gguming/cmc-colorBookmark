//
//  ChangeNicknameResponse.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/26.
//

import Foundation

struct ChangeNicknameResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
