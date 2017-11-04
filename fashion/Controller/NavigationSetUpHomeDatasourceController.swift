//
//  NavigationSetUpHomeDatasourceController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/19.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit

extension HomeDatasourceController {
    
    func setupLeftNavigationController() {
        //populate the left side of the navigation bar
        let followButton = UIButton(type: .system)
        //with rendering mode is to maintain the original color of the image
        followButton.setImage(#imageLiteral(resourceName: "tabCamera").withRenderingMode(.alwaysOriginal), for: .normal)
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)

    }
    
    func setupRightNavigationController() {
        //populate the left side of the navigation bar
        let searchButton = UIButton(type: .system)
        //with rendering mode is to maintain the original color of the image
        searchButton.setImage(#imageLiteral(resourceName: "tabMessage").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: searchButton), UIBarButtonItem(customView: searchButton)]
    }
    
    func setupOtherNavigationController() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        //hide navigation bar on swipe
        //        self.navigationController?.hidesBarsOnSwipe = true

    }
    
}
