//
//  AudioViewController.swift
//  ColorBookMark
//
//  Created by SUN on 2021/11/28.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController, AVAudioPlayerDelegate , AVAudioRecorderDelegate {
    
    

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    var soundRecorder : AVAudioRecorder?
    var soundPlayer : AVAudioPlayer?
    var progressTimer : Timer?
    var fileName: String = "audioFile.m4a"
    
    
    let timePlayerSelector:Selector = #selector(AudioViewController.updatePlayTime)
    let timeRecordSelector:Selector = #selector(AudioViewController.updateRecordTime)
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setupRecorder()
        saveBtn.isEnabled = false
        playBtn.isEnabled = false
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
        if playBtn.imageView?.image == UIImage(systemName: "play.fill") {
            print(1)
            playBtn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            recordBtn.isEnabled = false
            setupPlayer()
            soundPlayer?.play()
//            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        } else {
            print(122)
            soundPlayer?.stop()
            
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
            recordBtn.isEnabled = false
        }
    }
    
    @IBAction func recordBtnTapped(_ sender: Any) {
        if recordBtn.imageView?.image == UIImage(systemName: "circle.fill") {
            print(1)
            soundRecorder?.record()
            recordBtn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            playBtn.isEnabled = false
            saveBtn.isEnabled = false
            saveBtn.backgroundColor = hexStringToUIColor(hex: "#F2F2F2")
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        } else {
            print(122)
            soundRecorder?.stop()
            recordBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            saveBtn.isEnabled = true
            saveBtn.backgroundColor = UIColor.red
            setupPlayer()
            playBtn.isEnabled = false
            
        }
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        let recordInfo = RecordInfo.shared
        recordInfo.recordURL = audioFilename
        print(audioFilename)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        let recordSetting = [ AVFormatIDKey : kAudioFormatAppleLossless,
                              AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey : 320000,
                              AVNumberOfChannelsKey : 2,
                              AVSampleRateKey : 44100.2] as [String : Any]
        
        do {
            soundRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting )
            soundRecorder?.delegate = self
            soundRecorder?.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            soundPlayer?.delegate = self
            soundPlayer?.stop()
            soundPlayer?.currentTime = 0
//            progress.progress = 0
//            endTime.text = convertNSTimeInterval12String(soundPlayer.duration)
//            infoLabel.text = convertNSTimeInterval12String(0)
            
            soundPlayer?.prepareToPlay()
            soundPlayer?.volume = 1.0
        } catch {
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playBtn.isEnabled = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordBtn.isEnabled = true
        playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
   
    
    func convertNSTimeInterval12String(_ time:TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    @objc func updatePlayTime(){
//        infoLabel.text = convertNSTimeInterval12String(soundPlayer.currentTime) // 재생 시간인 audioPlayer.currentTime을 lblCurrentTime에 나타냄
//        progress.progress = Float(soundPlayer.currentTime/soundPlayer.duration) // 프로그레스(Progress View)인 pvProgressPlay의 진행 상황에 audioPlayer.currentTime을 audioPlayer.duration으로 나눈 값으로 표시
    }
    @objc func updateRecordTime(){
        infoLabel.text = convertNSTimeInterval12String(soundRecorder?.currentTime)
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


