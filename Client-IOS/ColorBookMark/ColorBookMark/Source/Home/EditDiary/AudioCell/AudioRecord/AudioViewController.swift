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
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var progressTimer : Timer!
    var fileName: String = "audioFile.m4a"
    
    
    let timePlayerSelector:Selector = #selector(AudioViewController.updatePlayTime)
    let timeRecordSelector:Selector = #selector(AudioViewController.updateRecordTime)
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
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
            playBtn.setImage(systemName: "stop.fill")
            recordBtn.isEnabled = false
            setupPlayer()
            soundPlayer.play()
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        } else {
            soundPlayer.stop()
            playBtn.setTitle("Play", for: .normal)
            
            recordBtn.isEnabled = false
        }
    }
    
    @IBAction func recordBtnTapped(_ sender: Any) {
        if recordBtn.imageView?.image == UIImage(systemName: "circle.fill") {
            soundRecorder.record()
            recordBtn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            playBtn.isEnabled = false
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        } else {
            soundRecorder.stop()
            recordBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            setupPlayer()
            playBtn.isEnabled = false
        }
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
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
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            soundPlayer.delegate = self
            soundPlayer.stop()
            soundPlayer.currentTime = 0
//            progress.progress = 0
//            endTime.text = convertNSTimeInterval12String(soundPlayer.duration)
            infoLabel.text = convertNSTimeInterval12String(0)
            
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
        } catch {
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playBtn.isEnabled = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordBtn.isEnabled = true
//        playBtn.setTitle("Play", for: .normal)
    }
    
    @IBAction func recordAct(_ sender: Any) {
        
        
       
    }
    
    @IBAction func playAct(_ sender: Any) {
        
      
    }
    
    func convertNSTimeInterval12String(_ time:TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    @objc func updatePlayTime(){
        infoLabel.text = convertNSTimeInterval12String(soundPlayer.currentTime) // 재생 시간인 audioPlayer.currentTime을 lblCurrentTime에 나타냄
//        progress.progress = Float(soundPlayer.currentTime/soundPlayer.duration) // 프로그레스(Progress View)인 pvProgressPlay의 진행 상황에 audioPlayer.currentTime을 audioPlayer.duration으로 나눈 값으로 표시
    }
    @objc func updateRecordTime(){
        infoLabel.text = convertNSTimeInterval12String(soundRecorder.currentTime)
    }
    

}
