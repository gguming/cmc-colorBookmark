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
    static var jwt: String?
   = UserDefaults.standard.string(forKey: "checkjwt")
    {
       
        didSet {
           // UserDefault에 저장
           guard let jwt = jwt else { return }
           print("jwt: \(jwt)")
           UserDefaults.standard.setValue(jwt, forKey: "checkjwt")
       }
    }
    static var settingArray = ["N", "N", "N"]
    static let SERVER_BASE_URL = "https://saekalpi.shop"
   
}

//MARK: UserDefaults
//Nickname
