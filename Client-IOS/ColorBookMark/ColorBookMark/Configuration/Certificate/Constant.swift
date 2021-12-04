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
   = UserDefaults.standard.string(forKey: "checkJwt")
    {
        didSet {
           // UserDefault에 저장
           guard let jwt = jwt else { return }
           print("jwt: \(jwt)")
           UserDefaults.standard.setValue(jwt, forKey: "checkJwt")
       }
    }
    
    static var nickname: String?
   = UserDefaults.standard.string(forKey: "checkNickname")
    {
        didSet {
           // UserDefault에 저장
           guard let nickname = nickname else { return }
           print("nickname: \(nickname)")
           UserDefaults.standard.setValue(jwt, forKey: "checkNickname")
       }
    }
    
    static var setting_0: String?
   = UserDefaults.standard.string(forKey: "checkSetting_0")
    {
        didSet {
           // UserDefault에 저장
           guard let setting_0 = setting_0 else { return }
           print("setting_0: \(setting_0)")
           UserDefaults.standard.setValue(setting_0, forKey: "checkSetting_0")
       }
    }
    
    static var setting_1: String?
   = UserDefaults.standard.string(forKey: "checkSetting_1")
    {
        didSet {
           // UserDefault에 저장
           guard let setting_1 = setting_1 else { return }
           print("setting_1: \(setting_1)")
           UserDefaults.standard.setValue(setting_1, forKey: "checkSetting_1")
       }
    }
    
    static var setting_2: String?
   = UserDefaults.standard.string(forKey: "checkSetting_2")
    {
        didSet {
           // UserDefault에 저장
           guard let setting_2 = setting_2 else { return }
           print("setting_2: \(setting_2)")
           UserDefaults.standard.setValue(setting_2, forKey: "checkSetting_2")
       }
    }
    
    static var miniCode: String?
   = UserDefaults.standard.string(forKey: "checkMiniCode")
    {
        didSet {
           // UserDefault에 저장
           guard let miniCode = miniCode else { return }
           print("miniCode: \(miniCode)")
           UserDefaults.standard.setValue(miniCode, forKey: "checkMiniCode")
       }
    }
    
    static var email: String?
   = UserDefaults.standard.string(forKey: "checkEmail")
    {
        didSet {
           // UserDefault에 저장
           guard let email = email else { return }
           print("email: \(email)")
           UserDefaults.standard.setValue(email, forKey: "checkEmail")
       }
    }
    
    static var userId: Int?
   = UserDefaults.standard.integer(forKey: "checkUserId")
    {
        didSet {
           // UserDefault에 저장
           guard let userId = userId else { return }
           print("userId: \(userId)")
           UserDefaults.standard.set(userId, forKey: "checkUserId")
       }
    }

    static var notFirstTimeLaunch: Bool?
   = UserDefaults.standard.bool(forKey: "checkNotFirstTimeLaunch")
    {
        didSet {
           // UserDefault에 저장
           guard let notFirstTimeLaunch = notFirstTimeLaunch else { return }
           print("notFirstTimeLaunch: \(notFirstTimeLaunch)")
           UserDefaults.standard.set(notFirstTimeLaunch, forKey: "checkNotFirstTimeLaunch")
       }
    }
    
    static var didLogin: Bool?
   = UserDefaults.standard.bool(forKey: "checkDidLogin")
    {
        didSet {
           // UserDefault에 저장
           guard let didLogin = didLogin else { return }
           print("didLogin: \(didLogin)")
           UserDefaults.standard.set(didLogin, forKey: "checkDidLogin")
       }
    }
    

    static let SERVER_BASE_URL = "https://saekalpi.shop"
   
}

//MARK: UserDefaults
//Nickname
