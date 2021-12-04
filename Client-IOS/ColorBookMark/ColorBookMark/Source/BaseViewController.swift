//
//  ViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/10/30.
//

import UIKit

class BaseViewController: UIViewController {
    var backgroundColors: [BackColors]?
    var gradientLayer = CAGradientLayer()
    lazy var backcolorDataManager: BackgroundColorDataManager = BackgroundColorDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        backcolorDataManager.getBackgroundColors(delegate: self)
    }
    
    func setBackgroundColors() {
        
        let colors: [CGColor] = [hexStringToUIColor22(hex: backgroundColors?[0].color ?? "#FFFFFF").cgColor,
                                  hexStringToUIColor22(hex: backgroundColors?[1].color ?? "#FFFFFF").cgColor,
                                  hexStringToUIColor22(hex: backgroundColors?[2].color ?? "#FFFFFF").cgColor]
        let changeColors: [CGColor] = [
           .init(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
           .init(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
           .init(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        ]

        
        gradientLayer.frame  = self.view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)

        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.toValue = changeColors
        colorAnimation.duration = 10
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = .infinity
        gradientLayer.add(colorAnimation, forKey: "colorChangeAnimation")
        
        let layer = CALayer()
        layer.frame = self.view.bounds
        layer.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor
        self.view.layer.insertSublayer(layer, at: 1)

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

