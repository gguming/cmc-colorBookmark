//
//  DeleteDiaryResponse.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/07.
//

import Foundation


struct DeleteDiaryResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String?
}
