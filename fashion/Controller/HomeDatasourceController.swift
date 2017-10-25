//
//  HomeDataSourceController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import LBTAComponents


//controller for the feed screen
class HomeDatasourceController: DatasourceController {
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpNavigationItems()

        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        collectionView?.backgroundColor = .white
        
        
        
        let homeDatasource = HomeDatasource()
        self.datasource = homeDatasource
        
//        homeDatasource.fetchFromDatabase()
//        self.collectionView?.reloadData()
        homeDatasource.fetchFromDatabase() {
            self.collectionView?.reloadData()
        }
    }
    
    //change the sapcing between each cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    private func setUpNavigationItems() {
        //change the navigation bar title
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "navigationTitle"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
//        navigationItem.title = "Feed"
        
        setupLeftNavigationController()
        setupRightNavigationController()
        setupOtherNavigationController()
        
    }
    
    //return the size of cell
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let post = self.datasource?.item(indexPath) as? Post {
            
            //get estimation of the height of the cell based on status text
            let approximateWidthOfStatusTextView = view.frame.width - 16
            let displaySize = CGSize(width: approximateWidthOfStatusTextView, height: 1000)
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
            
            let estimatedFrame = NSString(string: post.statusText!).boundingRect(with: displaySize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            //14 is for the padding of the status text view
            //52 is the height of other stuff eg images views
            let statusImageViewHeight = view.frame.width
            let postButtonWrapperHeight = (34 + 12) as CGFloat
            return CGSize(width: view.frame.width, height: estimatedFrame.height + statusImageViewHeight + postButtonWrapperHeight + 52 + 14)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
}
