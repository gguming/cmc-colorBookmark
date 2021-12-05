//
//  EditColorViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/17.
//

import UIKit

protocol ColorCollectionViewCellDelegate {
    func selectedColorCircle(index: Int)
    func selectedColorName(index: Int)
}

class EditColorViewController: UIViewController {
    
    var colors: [Colors]?

    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var collectionview: UICollectionView!
    
    lazy var colorDataManager: GetColorListDataManager = GetColorListDataManager()
    
    @IBAction func confirmBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.register(UINib(nibName: "ColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCollectionViewCell")
        collectionview.register(UINib(nibName: "EditColorBtnCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EditColorBtnCollectionViewCell")
        
        collectionview.dataSource = self
        collectionview.delegate = self
        setUI()
    }
    
    private func setUI() {
        resetBtn.clipsToBounds = true
        confirmBtn.clipsToBounds = true
        resetBtn.layer.cornerRadius = 13
        confirmBtn.layer.cornerRadius = 15
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
    
    func getColor() {
        colorDataManager.getColorsinEditColor(delegate: self)
    }
      
}

extension EditColorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + (colors?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditColorBtnCollectionViewCell", for: indexPath) as? EditColorBtnCollectionViewCell else {return UICollectionViewCell()}
            cell.delegate = self
            return cell
//        case 1...(colors?.count ?? 0):
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else {return UICollectionViewCell()}
            cell.setUI()
            cell.colorView.backgroundColor = hexStringToUIColor(hex: "\(colors?[indexPath.item-1].color ?? "#000000")")
            cell.colorNameLabel.text = colors?[indexPath.item-1].colorName
            cell.index = indexPath.row
            cell.colorDelegate = self
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104.0, height: 148.0)
    }
    
    
}

extension EditColorViewController: ClickEditBtn {
    func presentColorPicker() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ColorPickerMainViewController") as? ColorPickerMainViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.view.alpha = 0.3
        vc.view.backgroundColor = .black.withAlphaComponent(0.3)
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

extension EditColorViewController {
    func didSuccessGetColors(_ result: ColorResponse) {
        print("------>\(result)")
        colors = result.result
        collectionview.reloadData()
       
        
    }
    
    func failedToGetColors(message: String) {
        print("------>>>>\(message)")
        
    }
    
}

extension EditColorViewController: ColorCollectionViewCellDelegate{
    func selectedColorName(index: Int) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "OriginalColorPickerMainViewController") as? OriginalColorPickerMainViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.view.alpha = 0.3
        vc.view.backgroundColor = .black.withAlphaComponent(0.3)
        self.present(vc, animated: true, completion: nil)
//        이거 한다음에
//        데이터매니져에 연결후에 델리겟으로
//        reloadData 하기

    }
    
    func selectedColorCircle(index: Int) {
        //        데이터매니져에 연결한 다음에
        //        reloadData
    }

}
