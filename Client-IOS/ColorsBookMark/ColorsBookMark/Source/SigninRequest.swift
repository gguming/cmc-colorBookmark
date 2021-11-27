//
//  SigninRequest.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/09.
//

import Foundation

struct SigninRequest: Encodable {
    var email: String
    var password: String
    var nickname: String
}
