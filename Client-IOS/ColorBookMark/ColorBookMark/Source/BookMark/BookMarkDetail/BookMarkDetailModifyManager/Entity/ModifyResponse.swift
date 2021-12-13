//
//  ModifyResponse.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/14.
//

import Foundation

struct ModifyResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String?
}
