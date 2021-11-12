//
//  LoginRequest.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/12.
//

import Foundation

struct LoginRequest: Encodable {
    var email: String
    var password: String
}
