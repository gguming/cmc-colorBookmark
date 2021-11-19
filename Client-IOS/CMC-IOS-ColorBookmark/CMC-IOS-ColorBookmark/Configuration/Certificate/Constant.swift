//
//  Constant.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/10/31.
//

import Foundation


struct Constant {
    
    static var panelState = 0
    static var constantNum = 1
    static var checkFirst: Int?
   = UserDefaults.standard.integer(forKey: "checkFirst")
    {
           didSet {
               // UserDefault에 저장
               guard let num = checkFirst else { return }
               print("TOKEN: \(num)")
               UserDefaults.standard.setValue(num, forKey: "checkFirst")
           }
       }
    static let SERVER_BASE_URL = "https://saekalpi.shop"

}
