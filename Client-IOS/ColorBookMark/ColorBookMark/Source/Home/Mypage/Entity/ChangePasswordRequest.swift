//
//  ChangePasswordRequest.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/25.
//

import Foundation

struct ChangePasswordRequest: Encodable {
    var password1: String
    var password2: String
}
