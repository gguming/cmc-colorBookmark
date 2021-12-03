//
//  PostDiaryRequest.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/02.
//

import Foundation

struct PostDiaryRequest: Encodable{
    var content: String?
    var recordContent: String?
    var color: String?
    var colorName: String?
    var date: String?
    var diaryImgUrl: [String]?
    var isManyImg = "Y"
}