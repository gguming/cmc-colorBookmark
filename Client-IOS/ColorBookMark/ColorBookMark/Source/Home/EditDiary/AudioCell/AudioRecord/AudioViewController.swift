//
//  AudioViewController.swift
//  ColorBookMark
//
//  Created by SUN on 2021/11/28.
//

import UIKit

class AudioViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        saveBtn.layer.cornerRadius = 6
        playBtn.layer.cornerRadius = 20
        playBtn.layer.borderWidth = 3
        playBtn.layer.borderColor = UIColor(red: 112, green: 112, blue: 112, alpha: 1).cgColor
        recordBtn.layer.cornerRadius = 40
        recordBtn.layer.masksToBounds = true
        recordBtn.layer.borderWidth = 3
        recordBtn.layer.borderColor = UIColor(red: 112, green: 112, blue: 112, alpha: 1).cgColor
        
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
    }
    
    @IBAction func recordBtnTapped(_ sender: Any) {
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
    }
    

}
