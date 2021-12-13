//
//  AppleLoginResponse.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/14.
//

import Foundation

struct AppleLoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: AppleLoginResult?
}

struct AppleLoginResult: Decodable {
    var jwt: String
    var userId: Int
}
