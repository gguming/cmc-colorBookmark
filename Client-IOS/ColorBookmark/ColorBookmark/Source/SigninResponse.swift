//
//  SigninResponse.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/09.
//

import Foundation

struct SigninResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
