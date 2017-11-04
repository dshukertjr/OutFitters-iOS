//
//  HomeDatasource.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit
import Foundation
import LBTAComponents
import Photos

//data source for the home scrren (feed screen)
class ComposePostImageDatasource: Datasource {
    
    
    
    var images = [ComposePostImageView]()
    
    
    func grabPhotos(completion: @escaping () -> Void) {
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    print("permission granted")
                    self.retrieveImages() {
                        completion()
                    }
                } else {
                    print("permission not granted")
                    //implement fsome kind of mechanism to reask the user for permission until the user accepts it
                }
            })
        }
        
        retrieveImages() {
            completion()
        }
        
        

        
    }
    
    
    func retrieveImages(completion: @escaping () -> Void) {
        let imageManager = PHImageManager.default()
        
        let numLoadEachTime = 40
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
//        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.deliveryMode = .fastFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
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
                        
                        let composePostImageView = ComposePostImageView()
                        
                        composePostImageView.image = image!
                        
                        composePostImageView.index = i
                        
                        self.images.append(composePostImageView)
                })
                
                if(i + 1 == loadEnd) {
                    completion()
                }
                
            }
            
        }else {
            
            print("you got no photos")
            
        }
    }
    
    func getHighResolutionImage(index: Int) -> UIImage {
        let imageManager = PHImageManager.default()
        
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
//        requestOptions.deliveryMode = .fastFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        
        var highResolutionImage = UIImage()

        if fetchResult.count > 0 {
            
            
            imageManager.requestImage(for: fetchResult.object(at: index) , targetSize: CGSize(width: 640, height: 640), contentMode: .aspectFill, options: requestOptions, resultHandler:
                {
                    image, error in
                    
                    
//                    UIGraphicsBeginImageContext(CGSize(width: 640, height: 640))
//                    image!.draw(in: CGRect(x: 0, y: 0, width: 640, height: 640))
//                    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//                    UIGraphicsEndImageContext()
                    
                    
                    highResolutionImage = image!
//                    highResolutionImage = newImage!

                    
            })

            
        }else {
            
            print("you got no photos")
            
        }

        return highResolutionImage

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

