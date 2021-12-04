//
//  PatchColorRequest.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/05.
//

import Foundation

struct PatchColorRequest: Encodable {
    let color: String?
    let colorName: String?
}
