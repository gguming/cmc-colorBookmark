//
//  PostMyColorResponse.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/06.
//

import Foundation

struct PostMyColorResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String?
}
