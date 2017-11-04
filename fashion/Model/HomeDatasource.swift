//
//  HomeDatasource.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import LBTAComponents
import Firebase

//data source for the home scrren (feed screen)
class HomeDatasource: Datasource {
    
    
    
    
    var posts = [Post]()
    
    
    
    func fetchFromDatabase(completion: @escaping () -> Void) {

        
//        //fetch data from realtime database
//        let rootRef = Database.database().reference()
//        rootRef.child("posts").queryOrderedByKey().queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (snapshot) in
//            print("***", snapshot.value!)
//            for child in snapshot.children.allObjects as! [DataSnapshot] {
//                print("child", child.key)
//
//                let data = child.value as! NSDictionary
//
//                let post = Post()
//
//                post.statusText = "some text"
//
//                //set the status text
//                if let statusText = data["statusText"] {
//                    post.statusText = statusText as? String
//                }
//
//                //set the status image if it exists
//                if let statusImage = data["statusImage"] {
//                    post.statusImageRef = statusImage as? String
//                }
//
//
//                post.userName = "team.sayapan"
//                post.profileImageName = "profile3"
//                //                    post.statusImageName = "status2"
//                self.posts.append(post)
//
//            }
//            completion()
//        })
        
        
        
        
        //read data from cloud firestore
        let db = Firestore.firestore()

        db.collection("posts").order(by: "createTime", descending: true).limit(to: 10).getDocuments() { (querySnapshot, err) in
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
                        post.statusImageRef = statusImage as? String
                    }


                    post.userName = "team.sayapan"
                    post.statusText = data["statusText"] as? String
                    post.profileImageName = "profile3"
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
