//
//  HomeDataSourceController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import LBTAComponents



class HomeDatasourceController: DatasourceController {
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let homeDatasource = HomeDatasource()
        self.datasource = homeDatasource
        
        
    }
}
