//
//  ModifyRequest.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/14.
//

import Foundation

struct ModifyRequest: Encodable {
    var content: String?
    var recordContent: String?
    var color: String?
    var colorName: String?
    var date: String?
    var diaryImgUrl: [String]?
}
