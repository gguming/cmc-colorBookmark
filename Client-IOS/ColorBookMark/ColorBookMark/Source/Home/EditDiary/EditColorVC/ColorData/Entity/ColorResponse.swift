//
//  ColorResponse.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/23.
//

import Foundation


struct ColorResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [Colors]?
    
}


struct Colors: Decodable {
    var myColorId: Int
    var color: String?
    var colorName: String?
}
