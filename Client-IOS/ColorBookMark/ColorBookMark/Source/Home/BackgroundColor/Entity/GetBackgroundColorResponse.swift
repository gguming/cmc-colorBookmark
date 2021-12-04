//
//  GetBackgroundColorResponse.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/04.
//

import Foundation


struct GetBackgroundColorResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [BackColors]?
    
}


struct BackColors: Decodable {
    var color: String?
    var count: Int?
}

