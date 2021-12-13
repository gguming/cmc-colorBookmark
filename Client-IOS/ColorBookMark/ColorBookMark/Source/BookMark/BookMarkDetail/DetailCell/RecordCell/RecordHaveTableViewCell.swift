//
//  RecordHaveTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/03.
//

import UIKit
import AVFoundation

class RecordHaveTableViewCell: UITableViewCell, AVAudioPlayerDelegate{

    @IBOutlet weak var backView: UIView!
    var record: String?
    @IBOutlet weak var progressVIew: UIProgressView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var deleteDelegate: DeleteRecordDelegate?
    var progressTimer : Timer!
    let timePlayerSelector:Selector = #selector(RecordHaveTableViewCell.updatePlayTime)
    
    var player: AVPlayer?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
        progressVIew.layer.cornerRadius = 20
        progressVIew.clipsToBounds = true
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteBtnTapped(_ sender: Any) {
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        
        if playBtn.imageView?.image == UIImage(systemName: "play.fill") {
            //        print(1)
            playBtn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            let url = record ?? ""
            let playerItem = AVPlayerItem( url:NSURL( string:url )! as URL )
            player = AVPlayer(playerItem: playerItem)
            //                setupPlayer()
            player?.play()
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        } else {
            print(122)
            player?.pause()
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }


    }
    func convertCMTime12String(_ time:CMTime) -> String {
        let duration = CMTimeGetSeconds(time)
        let min = Int(duration/60)
        let sec = Int(duration.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    @objc func updatePlayTime(){
//        currentTime.text = convertNSTimeInterval12String(soundPlayer.currentTime) // 재생 시간인 audioPlayer.currentTime을 lblCurrentTime에 나타냄
//        progress.progress = Float(soundPlayer.currentTime/soundPlayer.duration)
        
        recordLabel.text = convertCMTime12String((player?.currentItem?.asset.duration)!) // 재생 시간인 audioPlayer.currentTime을 lblCurrentTime에 나타냄
        progressVIew.progress = Float(CMTimeGetSeconds((player?.currentTime())!)/CMTimeGetSeconds((player?.currentItem?.asset.duration)!))
        // 프로그레스(Progress View)인 pvProgressPlay의 진행 상황에 audioPlayer.currentTime을 audioPlayer.duration으로 나눈 값으로 표시
    }
//    @objc func updateRecordTime(){
//        recordTime.text = convertNSTimeInterval12String(soundRecorder.currentTime)
//    }
//
}


