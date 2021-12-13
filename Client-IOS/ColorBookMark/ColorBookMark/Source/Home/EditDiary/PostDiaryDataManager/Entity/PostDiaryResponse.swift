//
//  PostDiaryResponse.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/02.
//

import Foundation

struct PostDiaryResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
//    var result: String?
}
