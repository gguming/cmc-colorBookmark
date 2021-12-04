//
//  OriginalColorPickerViewController.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/05.
//

import UIKit


@available(iOS 14.0, *)
class OriginalColorPickerViewController: UIColorPickerViewController {

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
extension OriginalColorPickerViewController: UIColorPickerViewControllerDelegate{
    func originalColorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = hexStringFromColor(color: viewController.selectedColor)
        let colorInfo = ColorPickerInfo.shared
        colorInfo.color = color
        print(color)
    }
}

