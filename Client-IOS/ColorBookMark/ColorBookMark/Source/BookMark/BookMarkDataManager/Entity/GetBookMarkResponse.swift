//
//  getBookMarkResponse.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/06.
//

import Foundation

struct GetBookMarkResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String?
    var result: [BookMarks]?
}

struct BookMarks: Decodable{
    var selectMonthDiary: BookMarkInfo?
}

struct BookMarkInfo: Decodable {
    var diaryView: DiaryView?
    var diaryContents: [String]?
}

struct DiaryView: Decodable{
    var date: String?
    var diaryId: Int?
    var color: String?
    var colorName: String?
    var userId: Int?
    var content: Int?
    var recordContent: Int?
    var diaryImgUrl: Int?
}
