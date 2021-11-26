//
//  PostColorResponse.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/26.
//

import Foundation

struct PostColorResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String?
}
