//
//  ChangeNicknameRequest.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/26.
//

import Foundation

struct ChangeNicknameRequest: Encodable {
    var nickname: String
    var miniCode: String?
}
