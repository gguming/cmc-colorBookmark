//
//  SettingResonse.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/23.
//

import Foundation

struct SettingResonse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
