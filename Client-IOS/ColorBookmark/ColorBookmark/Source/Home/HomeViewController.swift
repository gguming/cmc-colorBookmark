//
//  HomeViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/05.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
import FloatingPanel

class HomeViewController: UIViewController {

    @IBAction func BookmarkButtonTapped(_ sender: Any) {
        let SB = UIStoryboard(name: "BookMark", bundle: nil)
        guard let vc = SB.instantiateViewController(withIdentifier: "BookmarkViewController") as? BookmarkViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @IBAction func SettingButtonTapped(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @IBAction func CalenderButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CalenderViewController") as! CalenderViewController
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = self.view.frame.height * 0.6
        present(bottomSheet, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var CalenderView: UIView!
    @IBOutlet weak var CalenderButton: UIButton!
    
    // Color section
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var collectionview: UICollectionView!
    
    // color data
    
    lazy var colorDataManager: GetColorListDataManager = GetColorListDataManager()
    var colors: [Colors]?
    
    
    // Action for color
    @IBAction func editBtnTapped(_ sender: Any) {
        
        editColorVC()
    }
    
    override func viewDidLoad() {
        print("qweqweqwe")
        print(JwtInfo.shared.jwtValue!)
        super.viewDidLoad()
        calendarSetUI()
        colorviewSetUI()
        collectionview.register(UINib(nibName: "ColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCollectionViewCell")
        collectionview.dataSource = self
        collectionview.delegate = self
        colorDataManager.getColors(delegate: self)

    }
    
    private func editDiaryVC(){
//        let fpc = FloatingPanelController()
        let fpc = FloatingPanelController()
        fpc.surfaceView.layer.cornerRadius = 10
        
        let appearance = SurfaceAppearance()
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "EditDiaryViewController") as? EditDiaryViewController else {return}
        contentVC.colors = self.colors
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
        fpc.layout = EditDiaryPanelLayout()
        fpc.invalidateLayout()
        
        fpc.surfaceView.grabberHandle.isHidden = true

    }
    
    private func editColorVC(){
        let fpc = FloatingPanelController()
        
        fpc.surfaceView.layer.cornerRadius = 10
        
        let appearance = SurfaceAppearance()
        let sb = UIStoryboard(name: "EditColor", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "EditColorViewController") as? EditColorViewController else {return}
        vc.colors = self.colors
        fpc.set(contentViewController: vc)
        fpc.addPanel(toParent: self)
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
        fpc.layout = EditColorPanelLayout()
        fpc.invalidateLayout()
        fpc.panGestureRecognizer.isEnabled = false
        
        
        fpc.surfaceView.grabberHandle.isHidden = true

    }

    
    private func calendarSetUI(){
        let textColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy . MM . dd  "
        let currentDate = formatter.string(from: Date())
        let boldFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        let generalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: textColor, .font: boldFont]
        let calenderText = NSMutableAttributedString()
        calenderText.append(NSAttributedString(string: currentDate, attributes: generalAttributes))
        CalenderButton.setAttributedTitle(calenderText, for: .normal)
        
        CalenderView.layer.cornerRadius = 25
    }
    
    private func colorviewSetUI() {
        colorView.clipsToBounds = true
        colorView.layer.cornerRadius = 20
        colorView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        editBtn.clipsToBounds = true
        editBtn.layer.cornerRadius = 15
        
        
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
}



// collectionview setting

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else {return UICollectionViewCell()}
        cell.setUI()
        cell.colorView.backgroundColor = hexStringToUIColor(hex: "#\(colors?[indexPath.item].color ?? "000000")")
        cell.colorNameLabel.text = colors?[indexPath.item].colorName
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        editDiaryVC()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104.0, height: 148.0)
    }
    
    
    
    
    
}
// api 호출

extension HomeViewController {
    func didSuccessGetColors(_ result: ColorResponse) {
        print("------>\(result)")
        colors = result.result
        collectionview.reloadData()
       
        
    }
    
    func failedToGetColors(message: String) {
        print("------>>>>\(message)")
        
    }
    
}


