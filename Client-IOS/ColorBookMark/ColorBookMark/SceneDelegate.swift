//
//  SceneDelegate.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/10/30.
//

import UIKit
import KakaoSDKAuth
import AVFoundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var audioPlayer : AVAudioPlayer!
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            if let url = URLContexts.first?.url {
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        
        }

    //MARK: 앱 화면 입장
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("AAAAA", 4444)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        print("시작화면")
        
        //MARK: FIRST TIME
        if Constant.notFirstTimeLaunch == false {
            print("FIRST TIME")
            Constant.notFirstTimeLaunch = true
            let storyboard = UIStoryboard(name: "WalkThrough", bundle: nil)
            let vc_2 = storyboard.instantiateViewController(withIdentifier: "WalkThroughViewController")
            window?.rootViewController = vc_2
        }
        
        //MARK: NOT FIRST TIME
        else{
            //MARK: LOGIN OK
            if Constant.didLogin == true {
                print("LOGIN OK")
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let vc_1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                window?.rootViewController = vc_1
            }
            else {
                //MARK: LOGIN X
                print("LOGIN X")
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let vc_3 = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController")
                window?.rootViewController = vc_3
            }
           }
        window?.makeKeyAndVisible()
        
        if Constant.setting_2 == "Y" {
            print("음악 재시작")
            playBackgroundMusic()
        }
    }

    //MARK: 앱을 종료할 때
    func sceneDidDisconnect(_ scene: UIScene) {
        print("AAAAA", 3333)
//        if Constant.setting_2 == "Y" {
//            print("음악 종료")
//            audioPlayer?.stop()
//        }
        
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    //MARK: 여러창으로 갈 때
    func sceneWillResignActive(_ scene: UIScene) {
        print("AAAAA", 5555)
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    //MARK: 배경에서 다시 돌아올 때
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("AAAAA", 2222)
        if Constant.setting_2 == "Y" {
            print("음악 재시작")
            playBackgroundMusic()
        }
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    //MARK: 아예 배경화면으로 갈 때
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("AAAAA", 1111)

        if Constant.setting_2 == "Y" {
            print("음악 종료")
            audioPlayer?.stop()
        }
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func playBackgroundMusic() {
        guard let url = Bundle.main.path(forResource: "BackgroundMusic", ofType: "mp3")
        else {
            print("error to get the mp3 file")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: url)!)
        }
        catch {
            print("audio file error")
        }
        audioPlayer?.play()
    }
}

