//
//  ColorTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/10.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    var colors: [Colors]?

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var separateView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionview.register(UINib(nibName: "ColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCollectionViewCell")
        collectionview.dataSource = self
        collectionview.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
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

extension ColorTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else {return UICollectionViewCell()}
        cell.setUI()
        
        cell.colorView.backgroundColor = hexStringToUIColor(hex: "\(colors?[indexPath.item].color ?? "#000000")")
        cell.colorNameLabel.text = colors?[indexPath.item].colorName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104.0, height: 148.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let colorInfo = ColorPickerInfo.shared
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else {return}
//        
        colorInfo.color = colors?[indexPath.item].color
        colorInfo.colorName = colors?[indexPath.item].colorName
        
    }
    
    
}
