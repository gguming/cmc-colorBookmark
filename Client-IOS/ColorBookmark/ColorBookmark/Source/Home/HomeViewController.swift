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
//    var delegate: ChangeStateDelegate?
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
    
    @IBOutlet weak var CalenderView: UIView!
    @IBOutlet weak var CalenderButton: UIButton!
    
    @IBAction func CalenderButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CalenderViewController") as! CalenderViewController
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = self.view.frame.height * 0.6
        present(bottomSheet, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
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
        super.viewDidLoad()

       
//        
//        if Constant.constantNum == 1 {
//            let storyboard = UIStoryboard(name: "WalkThrough", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "WalkThroughViewController")
//            
//            changeRootViewController(vc)
//        }
        
        let fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.surfaceView.layer.cornerRadius = 10
        
        let appearance = SurfaceAppearance()

        // Define shadows
//        let shadow = SurfaceAppearance.Shadow()
//        shadow.color = UIColor.black
//        shadow.offset = CGSize(width: 0, height: 16)
//        shadow.radius = 16
//        shadow.spread = 8
//        appearance.shadows = [shadow]

        // Define corner radius and background color
      
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "EditDiaryViewController") as? EditDiaryViewController else {return}
        
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
        
        fpc.surfaceView.grabberHandle.isHidden = true
    }
    
    func changeHeaderUI(_ delegate: HeaderTableViewCell){
        delegate.checkState()
    }
}

//extension HomeViewController: EditBtnDelegate{
//    func presentEditVC() {
//        <#code#>
//    }
//    
//    
//}

extension HomeViewController: FloatingPanelControllerDelegate{
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        if fpc.state == .tip {
            Constant.panelState = 0
//            delegate?.changeState()
           
            
            print(Constant.panelState)
        } else {
            Constant.panelState = 1
//            delegate?.changeState()
            print(Constant.panelState)
        }
    }
}

//protocol ChangeStateDelegate{
//    func changeState()
//}