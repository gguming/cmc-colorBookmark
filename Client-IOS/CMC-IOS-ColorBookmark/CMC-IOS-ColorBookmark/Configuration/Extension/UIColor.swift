//
//  UIColor.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/10/31.
//

import Foundation
import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainPink
    class var mainPink: UIColor { UIColor(hex: 0xFF1C92) }
    
    class var mainBlack: UIColor{ UIColor(red: 49, green: 49, blue: 49, alpha: 1)}
    class var mainGray: UIColor{ UIColor(red: 108, green: 108, blue: 108, alpha: 1)}
    
}


