//
//  PostMyColorRequest.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/06.
//

import Foundation

struct PostMyColorRequest: Encodable {
    var color: String?
    var colorName: String?
    var myColorId: Int?
    var status: String?
}


