//
//  composePostController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/25.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit
import LBTAComponents
import Photos

class ComposePostController: DatasourceController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let composePostImageDatasource = ComposePostImageDatasource()

    let defaultCellId = "lbta_defaultCellId"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        navigationItem.title = "Choose Image"
        navigationController?.navigationBar.backgroundColor = .white

        
        //change the navigation bar title font color to black because the default is white for some reason
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.black]

        self.datasource = self.composePostImageDatasource
                
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ComposePostImageCell {
        
        let cell: ComposePostImageCell
        
        if let cls = datasource?.cellClass(indexPath) {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cls), for: indexPath) as! DatasourceCell as! ComposePostImageCell as! ComposePostImageCell
        } else if let cellClasses = datasource?.cellClasses(), cellClasses.count > indexPath.section {
            let cls = cellClasses[indexPath.section]
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cls), for: indexPath) as! DatasourceCell as! ComposePostImageCell
        } else if let cls = datasource?.cellClasses().first {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cls), for: indexPath) as! DatasourceCell as! ComposePostImageCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellId, for: indexPath) as! DatasourceCell as! ComposePostImageCell
        }
        
        cell.delegate = self
        
        cell.controller = self
        cell.datasourceItem = datasource?.item(indexPath)
        return cell
    }
    

    
    var canLoadMoreImage = true
    
    func loadMoreImage() {
        if(self.canLoadMoreImage) {
            self.canLoadMoreImage = false
            
            composePostImageDatasource.grabPhotos() {
                //reload cells after fetching new data
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                self.canLoadMoreImage = true
                print(self.canLoadMoreImage)
            }
        }
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        //excute function if within 200pt from bottom
        if offsetY > (contentHeight - scrollView.frame.size.height - 200) {
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


extension ComposePostController: ComposePostImageCellDelegate {
    func imageTapped(tappedImageView: ComposePostImageView){
        let editPostController = EditPostController()
//        editPostController.chosenImage = (tappedImageView.image?.squared)!
        editPostController.chosenImage = composePostImageDatasource.getHighResolutionImage(index: tappedImageView.index!).squared!
//        editPostController.chosenImage = tappedImageView.image!.squared!
        navigationController?.pushViewController(editPostController, animated: true)
    }
}

extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var squared: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

