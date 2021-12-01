//
//  AudioHaveTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/11/28.
//

import UIKit
import AVFoundation

class AudioHaveTableViewCell: UITableViewCell,  AVAudioPlayerDelegate {

    
    var soundPlayer : AVAudioPlayer!
    var progressTimer : Timer!
    
    @IBOutlet weak var durationTime: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let timePlayerSelector:Selector = #selector(AudioHaveTableViewCell.updatePlayTime)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupPlayer()
        playBtn.layer.cornerRadius = 24
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func playBtnTapped(_ sender: Any) {
        
        if playBtn.imageView?.image == UIImage(systemName: "play.fill") {
            print(1)
            playBtn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            setupPlayer()
            soundPlayer.play()
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        } else {
            print(122)
            soundPlayer.stop()
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    func setupPlayer() {
        let audioFilename = RecordInfo.shared.recordURL
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFilename!)
            soundPlayer.delegate = self
            soundPlayer.stop()
            soundPlayer.currentTime = 0
            progressBar.progress = 0
            durationTime.text = convertNSTimeInterval12String(soundPlayer.duration)
//            endTime.text = convertNSTimeInterval12String(soundPlayer.duration)
//            infoLabel.text = convertNSTimeInterval12String(0)
            
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
        } catch {
            print(error)
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
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
        progressBar.progress = Float(soundPlayer.currentTime/soundPlayer.duration) // 프로그레스(Progress View)인 pvProgressPlay의 진행 상황에 audioPlayer.currentTime을 audioPlayer.duration으로 나눈 값으로 표시
    }
}
