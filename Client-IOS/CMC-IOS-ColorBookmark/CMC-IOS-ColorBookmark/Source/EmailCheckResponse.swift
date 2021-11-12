//
//  EmailCheckResponse.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/11.
//

import Foundation

struct EmailCheckResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
