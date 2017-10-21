//
//  CustomTabBarController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/12.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //first tab setting start
        let homeDatasourceController = HomeDatasourceController()
        homeDatasourceController.title = "ホーム"
        let navigationController = UINavigationController(rootViewController: homeDatasourceController)
        
        //        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "tabHome")
        //first tab setting end
        
        //second tab setting start
        let homeDatasourceController2 = HomeDatasourceController()
        homeDatasourceController2.title = "いいね"
        let navigationController2 = UINavigationController(rootViewController: homeDatasourceController2)
        
        //        navigationController.title = "News Feed"
        navigationController2.tabBarItem.image = #imageLiteral(resourceName: "tabIine")
        //second tab setting end
        
        //third tab setting start
        let homeDatasourceController3 = HomeDatasourceController()
        homeDatasourceController3.title = "マイページ"
        let navigationController3 = UINavigationController(rootViewController: homeDatasourceController3)
        
        //        navigationController.title = "News Feed"
        navigationController3.tabBarItem.image = #imageLiteral(resourceName: "tabMyPageIcon")
        //third tab setting end
        
        //four tab setting start
        let homeDatasourceController4 = HomeDatasourceController()
        homeDatasourceController4.title = "投稿"
        let navigationController4 = UINavigationController(rootViewController: homeDatasourceController4)
        
        //        navigationController.title = "News Feed"
        navigationController4.tabBarItem.image = #imageLiteral(resourceName: "tabPlus")
        //fourth tab setting end
        

        //second tab setting start
//        let friendRequestController = SecondViewController()
//        friendRequestController.title = "some title"
//        let secondNavigationController = UINavigationController(rootViewController: friendRequestController)
//        secondNavigationController.title = "Requests"
//        secondNavigationController.tabBarItem.image = UIImage(named: "request")
        //second tab setting end
        
        //add all of the view controllers
//        viewControllers = [navigationController, secondNavigationController]
        viewControllers = [navigationController,navigationController2,navigationController3,navigationController4]

        //turn off the transparency of tab bar
        tabBar.isTranslucent = false
        
        //take care of the border on top of the tab bar
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.8)
        topBorder.backgroundColor = UIColor(red: 299/255, green: 231/255, blue: 235/255, alpha: 1).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        //end taking care of the border on top of the tab bar
    }
    
}
