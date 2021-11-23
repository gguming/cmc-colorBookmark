//
//  LoginResponse.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/12.
//

import Foundation

struct LoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LoginResult?
}

struct LoginResult: Decodable{
    var userId: Int
    var jwt: String
    var nickname: String
}
