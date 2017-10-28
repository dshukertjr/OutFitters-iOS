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
    
    private func fetchPhotoAtIndexFromEnd(index: Int) {
        
    }
    
    
    func grabPhotos(completion: @escaping () -> Void) {
        
        let imageManager = PHImageManager.default()
        
        let numLoadEachTime = 40
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
//        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.deliveryMode = .fastFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
            
            if fetchResult.count > 0 {
                
                
                let loadStart = self.images.count
                var loadEnd = numLoadEachTime + loadStart
                if(fetchResult.count < loadEnd) {
                    loadEnd = fetchResult.count
                }
                
                for i in loadStart..<loadEnd {

                    imageManager.requestImage(for: fetchResult.object(at: i) , targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler:
                        {
                            image, error in
                            
                            let composePostImage = ComposePostImage()
                            
                            composePostImage.postImage = image!
                            
                            self.images.append(composePostImage)
                    })
                    
                    if(i + 1 == loadEnd) {
                        completion()
                    }
                    
                }
                
            }else {
                
                print("you got no photos")
                
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

