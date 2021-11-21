//
//  KakaoLoginResponse.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/20.
//

import Foundation

struct KakaoLoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: KakaoLoginResult?
}

struct KakaoLoginResult: Decodable {
    var message: String
    var jwt: String
}
