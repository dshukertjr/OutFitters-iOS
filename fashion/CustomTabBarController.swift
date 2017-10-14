//
//  CustomTabBarController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/12.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //first tab setting start
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        feedController.title = "Feed"
        let navigationController = UINavigationController(rootViewController: feedController)
        
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "newspaper")
        //first tab setting end
        
        
        //second tab setting start
        let friendRequestController = SecondViewController()
        friendRequestController.title = "some title"
        let secondNavigationController = UINavigationController(rootViewController: friendRequestController)
        secondNavigationController.title = "Requests"
        secondNavigationController.tabBarItem.image = UIImage(named: "request")
        //second tab setting end
        
        //add all of the view controllers
        viewControllers = [navigationController, secondNavigationController]
        
        //turn off the transparency of tab bar
        tabBar.isTranslucent = false
        
        //change the height of the bar at the top of the tab bar
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor(red: 299/255, green: 231/255, blue: 235/255, alpha: 1).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
    
}
