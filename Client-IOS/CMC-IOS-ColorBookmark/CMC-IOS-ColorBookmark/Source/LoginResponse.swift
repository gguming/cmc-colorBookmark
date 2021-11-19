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
    let userId: Int
    let jwt: String
}
