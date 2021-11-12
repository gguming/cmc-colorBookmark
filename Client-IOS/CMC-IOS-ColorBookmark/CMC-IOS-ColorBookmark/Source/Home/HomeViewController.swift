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

    @IBAction func ToSetting(_ sender: Any) {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Constant.constantNum == 1 {
            let storyboard = UIStoryboard(name: "WalkThrough", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WalkThroughViewController")
            
            changeRootViewController(vc)
        }
        
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
}


extension HomeViewController: FloatingPanelControllerDelegate{
    
}
