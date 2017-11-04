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
//        homeDatasourceController.title = "ホーム"
        let navigationController = UINavigationController(rootViewController: homeDatasourceController)
        
        //        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "tabHome")
        //first tab setting end
        
//second tab setting start
        let likes = HomeDatasourceController()
//        homeDatasourceController2.title = "いいね"
        let navigationLikes = UINavigationController(rootViewController: likes)
        
        //        navigationController.title = "News Feed"
        navigationLikes.tabBarItem.image = #imageLiteral(resourceName: "tabIine")
//second tab setting end
        
//third tab setting start
        let composePost = ComposePostController()
        
        let navigationComposePost = UINavigationController(rootViewController: composePost)
        
        navigationComposePost.tabBarItem.image = #imageLiteral(resourceName: "tabPlus")

//third tab setting end
        
//four tab setting start
        let myPage = HomeDatasourceController()
        //        homeDatasourceController3.title = "マイページ"
        let navigationMyPage = UINavigationController(rootViewController: myPage)
        
        //        navigationController.title = "News Feed"
        navigationMyPage.tabBarItem.image = #imageLiteral(resourceName: "tabMyPageIcon")
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
        viewControllers = [navigationController,navigationLikes, navigationComposePost,navigationMyPage]

        //turn off the transparency of tab bar
        tabBar.isTranslucent = false
        
        //take care of the border on top of the tab bar
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.8)
        topBorder.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        //end taking care of the border on top of the tab bar
        
        
        //move the tab bar button image down a little bit
        for vc in self.viewControllers! {
//            vc.tabBarItem.title = nil
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        }

    }
    
    
    //change the tab bar height
    let barHeight: CGFloat = 50.0
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        var tabFrame = tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = view.frame.size.height - barHeight - 1
        tabBar.frame = tabFrame
    }
    
    
}


