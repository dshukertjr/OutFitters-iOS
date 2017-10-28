//
//  composePostController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/25.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit
import LBTAComponents

class ComposePostController: DatasourceController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let composePostImageDatasource = ComposePostImageDatasource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        self.parent?.navigationItem.title = "New"

        
        self.datasource = self.composePostImageDatasource
    }
    
    
    var canLoadMoreImage = true
    func loadMoreImage() {
        if(self.canLoadMoreImage) {
            self.canLoadMoreImage = false
            
            composePostImageDatasource.grabPhotos() {
                //reload cells after fetching new data
                self.collectionView?.reloadData()
                self.canLoadMoreImage = true
                print(self.canLoadMoreImage)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        loadMoreImage()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        //excute function if within 100pt from bottom
        if offsetY > (contentHeight - scrollView.frame.size.height - 100) {
            //function to load more images
            loadMoreImage()
        }
    }
        
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 4 - 1.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    
    
    
    
    
    
//    func openImagePicker() {
//        let picker = UIImagePickerController()
//
//        picker.delegate = self
//        picker.allowsEditing = true
//
//        present(picker, animated: true, completion:nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print(info)
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("cancelled")
//        dismiss(animated: true, completion: nil)
//    }
    
    
}
