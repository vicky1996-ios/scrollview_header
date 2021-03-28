//
//  AppDelegate.swift
//  DinDinnTask
//
//  Created by Codigo Technologies on 28/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var lettersArr = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        //TASK: 1
        
        self.lettersPosionGetting("abc",2)
        self.lettersPosionGetting("abc",28)

        return true
    }
    func lettersPosionGetting(_ giverStr:String,_ changeIndex:Int){
        
        var outputStr = ""
        let givenStrArr = giverStr
        
        for char in givenStrArr {
            let indexNo = (lettersArr.firstIndex(of: "\(char)") ?? 0) + (changeIndex % lettersArr.count)
 
            outputStr += lettersArr[indexNo]
        }
        print(outputStr)
    }
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
             return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

