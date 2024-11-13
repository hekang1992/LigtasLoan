//
//  LLTabBarViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/11/12.
//

import UIKit

class LLTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 10
        
        let homeVC = LLSYViewController()
        let profileVC = LLCenterViewController()
        
        homeVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "homenormal")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "homesel")?.withRenderingMode(.alwaysOriginal)
        )
        
        profileVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "cennormal")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "censel")?.withRenderingMode(.alwaysOriginal)
        )
        
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        profileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        viewControllers = [
            LLBaseNavViewController(rootViewController: homeVC),
            LLBaseNavViewController(rootViewController: profileVC)
        ]
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
    }
}
