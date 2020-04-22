//
//  BaseTabBarController.swift
//  AppStoreJSONApis
//
//  Created by Aleksei Danilov on 22.04.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: AppSearchController(), title: "Search", imageName: "search"),
            createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            createNavController(viewController: UIViewController(), title: "Apps", imageName: "apps")
        ]
    }
    
    private func createNavController(
        viewController: UIViewController,
        title: String,
        imageName: String
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}
