//
//  AppDelegate.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var ff = LLLaunchViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = ff
        window?.makeKeyAndVisible()
        return true
    }

}

