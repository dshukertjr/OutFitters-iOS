//
//  HomeDatasource.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import LBTAComponents
import Firebase
import FirebaseStorageUI

//data source for the home scrren (feed screen)
class HomeDatasource: Datasource {
    
    
    
//    let posts: [Post] = {
//
//
//    }()
    
    var posts = [Post]()
    
    
    func fetchFromDatabase(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        var posts = [Post]()
        //        let storageRef = Storage.storage().reference()
        
        db.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    //data contains the data from data base
                    let data = document.data()
                    
                    
                    let post = Post()
                    
                    
//                    if let statusImageName = data["statusImage"] {
//                        post.statusImageName = statusImageName as? String
//                    }
                    
                    //set the status image if it exists
                    if let statusImage = data["statusImage"] {
                        post.statusImageRef = statusImage as! String
                    }
                    
                    
                    post.userName = "Tyler Shukert"
                    post.statusText = data["statusText"] as? String
                    post.profileImageName = "profile1"
                    //                    post.statusImageName = "status2"
                    self.posts.append(post)

                    //                    self.collectionView?.reloadData()
                }
                //by calling completion, the collection view cells are being reloaded
                completion()
            }
        }
    }
    
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [HomeCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return posts[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return posts.count
    }
}
