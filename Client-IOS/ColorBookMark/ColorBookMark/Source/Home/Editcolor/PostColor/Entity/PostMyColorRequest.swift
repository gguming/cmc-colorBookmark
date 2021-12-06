//
//  PostMyColorRequest.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/06.
//

import Foundation

struct PostMyColorRequest: Encodable {
    let color: String
    let colorName: String?
    let myColorId: Int
    let status: String?
}
