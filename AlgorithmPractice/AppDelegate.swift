//
//  AppDelegate.swift
//  AlgorithmPractice
//
//  Created by Shukla, Jageen on 2020/05/24.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let node1 = LinkListExt(value: 1, next: nil)
        let node2 = LinkListExt(value: 2, next: nil)
        let node3 = LinkListExt(value: 3, next: nil)
        let node4 = LinkListExt(value: 4, next: nil)
        
        node1.next = node2;
        node1.random = node4;
        
        node2.next = node3;
        node2.random = node1;
        
        node3.next = node4;
        node3.random = node2;
        
        node4.random = node3;
        
        
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


}

