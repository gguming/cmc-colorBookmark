//
//  AppDelegate.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/10/30.
//

import UIKit
import KakaoSDKCommon
import Firebase
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var audioPlayer : AVAudioPlayer!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        KakaoSDK.initSDK(appKey: "e2a97fb8904d79724a04615b8f993706")
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
       
        return true
    }

    // MARK: UISceneSession Lifecycle
    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func playBackgroundMusic() {
        guard let url = Bundle.main.path(forResource: "BackgroundMusic", ofType: "mp3")
        else {
            print("error to get the mp3 file")
            return
        }
        do {
            print("왜안돼")
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: url)!)
        }
        catch {
            print("audio file error")
        }
        audioPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        completionHandler()
    }
}
