//
//  ViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/10/30.
//

import UIKit

class BaseViewController: UIViewController {
    var backgroundColors: [BackColors]?
    
    lazy var backcolorDataManager: BackgroundColorDataManager = BackgroundColorDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        backcolorDataManager.getBackgroundColors(delegate: self)
    }
    
    func setBackgroundColors() {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.frame
        gradient.colors = [hexStringToUIColor22(hex: backgroundColors?[0].color ?? "#FFFFFF").cgColor,
                           hexStringToUIColor22(hex: backgroundColors?[1].color ?? "#FFFFFF").cgColor,hexStringToUIColor22(hex: backgroundColors?[2].color ?? "#FFFFFF").cgColor]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.type = .radial
//        gradient.mask = shape

        self.view.layer.insertSublayer(gradient, at: 0)
        print(444444)
    }
    
    func hexStringToUIColor22 (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func didSuccessGetBackgroundColors(_ result: GetBackgroundColorResponse) {
        print("------>\(result)")
        backgroundColors = result.result
        setBackgroundColors()
        
        
       
        
    }
    
    func failedToBackgroundColors(message: String) {
        print("------>>>>\(message)")
        
    }


}

