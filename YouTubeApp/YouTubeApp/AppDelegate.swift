//
//  AppDelegate.swift
//  YouTubeApp
//
//  Created by Alexey Danilov on 05/09/2018.
//  Copyright © 2018 Alexey Danilov. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()
        
        window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = UIColor.rgb(red: 230, green: 32, blue: 32, alpha: 1)
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.setBackgroundImage(UIImage(), for: .default)
        
        application.statusBarStyle = .lightContent
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31, alpha: 1)
        
        window?.addSubview(statusBarBackgroundView)
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithFormat(format: "V:|[v0(20)]", views: statusBarBackgroundView)
        
        return true
    }
    
}

