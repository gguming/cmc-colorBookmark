//
//  ColorPickerViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/18.
//

import UIKit


@available(iOS 14.0, *)
class ColorPickerViewController: UIColorPickerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.supportsAlpha = false
        self.delegate = self
    }
    func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
     }

}

@available(iOS 14.0, *)
extension ColorPickerViewController: UIColorPickerViewControllerDelegate{
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = hexStringFromColor(color: viewController.selectedColor)
        let colorInfo = ColorPickerInfo.shared
        colorInfo.color = color
        print(color)
    }
}
