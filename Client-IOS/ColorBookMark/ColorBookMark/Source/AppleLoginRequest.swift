//
//  AppleLoginRequest.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/14.
//

import Foundation

struct AppleLoginRequest: Encodable {
    var authorizationCode: String
    var identityToken: String
}
