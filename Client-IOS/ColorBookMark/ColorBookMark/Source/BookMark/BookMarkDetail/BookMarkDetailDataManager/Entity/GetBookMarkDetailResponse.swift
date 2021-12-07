//
//  GetBookMarkDetailResponse.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/07.
//

import Foundation


struct GetBookMarkDetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Diary?
}

struct Diary: Decodable{
    var diary: DiaryInfo?
}

struct DiaryInfo: Decodable{
    var diaryImage: [DiaryImgUrl]?
    var diaryContents: DiaryContents?
}

struct DiaryImgUrl: Decodable {
    var diaryImgUrl: String?
}

struct DiaryContents: Decodable {
    var diaryId: Int?
    var color: String?
    var colorName: String?
    var nickname: String?
    var content: String?
    var recordContent: String?
    var date: String?
}
