//
//  HomeDatasource.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import LBTAComponents
import Photos

//data source for the home scrren (feed screen)
class ComposePostImageDatasource: Datasource {
    
    
    
    var images = [ComposePostImage]()
    
    
    func grabPhotos(completion: @escaping () -> Void) {
        
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
            
            if fetchResult.count > 0 {
                
                for i in 0..<fetchResult.count {
                    
                    imageManager.requestImage(for: fetchResult.object(at: i) , targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler:
                        {
                            image, error in
                            
                            let composePostImage = ComposePostImage()
                            
                            composePostImage.postImage = image!
                            
                            print("image")
                            
                            self.images.append(composePostImage)
                    })
                    
                }
                
            }else {
                
                print("you got no photos")
                completion()
//                self.collectionView?.reloadData()
            }
            
        }
    }

    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ComposePostImageCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return images[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return images.count
    }
    
}

