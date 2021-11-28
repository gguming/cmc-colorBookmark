//
//  DeleteAccountResponse.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/11/29.
//

import Foundation

struct DeleteAccountResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
