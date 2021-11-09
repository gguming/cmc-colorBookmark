//
//  TestHomeViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/07.
//

import UIKit
import FloatingPanel

class TestHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        //contentViewController
    }
    

   
}

extension TestHomeViewController: FloatingPanelControllerDelegate{

}