//
//  AudioBackgroundViewController.swift
//  ColorBookMark
//
//  Created by SUN on 2021/11/28.
//

import UIKit

class AudioBackgroundViewController: UIViewController{
    var recordSaveDelegate: recordSaveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recordSaveDelegate?.recordSave()
        
    }
    

    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

protocol recordSaveDelegate {
    func recordSave()
}
