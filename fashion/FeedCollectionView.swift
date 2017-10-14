//
//  ViewController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/05.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit
import Firebase

class Post {
    var name: String?
    var statusText: String?
    var profileImageName: String?
    var statusImageName: String?
    var statusImage: UIImage?
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let customCellIdentifier = "customCellIdentifier"
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        
        
//load data from cloud firestore
        let db = Firestore.firestore()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        db.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    let post = Post()
                    
                    
                    // Create a reference to the file you want to download
                    let islandRef = storageRef.child("posts").child(data["statusImage"] as! String)
                    
                    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                    islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Uh-oh, an error occurred!
                            print("error occured", error)
                        } else {
                            print("loaded")
                            let image = UIImage(data: data!)
                            post.statusImage = image
                        }
                    }
                    
                    
                    post.name = "Tyler Shukert"
                    post.statusText = data["statusText"] as! String
                    post.profileImageName = "profile1"
//                    post.statusImageName = "status2"
                    self.posts.append(post)
                    self.collectionView?.reloadData()
                }
            }
        }
//end getting the data from cloud firestore
        
        
        
        
        
        
        
        
        
//        navigationItem.title = "facebook feed"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: customCellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath.item]
        
        return feedCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    //go to another page when cell is tapped
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = SecondViewController()
        controller.line = "line sent"
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText {
            
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200
            
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 16)
            
        }
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    //resize when the screen size changes(rotated device)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
}


class FeedCell: UICollectionViewCell {
    
    var post: Post? {
        didSet{
            
            //            set the account's user name if it is set
            if let name = post?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: "\nDecember 18 • San Francisco • ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
                
                //adding gray lines after the main line
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0,attributedText.string.characters.count))
                
                //add little icon at the end of the text
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "icon")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                
                nameLabel.attributedText = attributedText
            }
            
            //            set the status text if it exists
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            //            setting the profile image
            if let profileImagename = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImagename)
            }
            
            //            setting status image
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }
            
            if let statusImage = post?.statusImage {
                statusImageView.image = statusImage
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    //setup for the name label
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    
    //set up for status text view
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "mean while sometinghappen ed"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    //set up for profile image view
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sample")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    //set up for status image view
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //add subviews and add constraints
    func setupViews(){
        backgroundColor = UIColor.white
        
        //add all the subviews
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: statusImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]|", views: profileImageView, statusTextView, statusImageView)
        
        //add constraints of name label
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(44)]-8-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView, "v1": nameLabel]))
        //
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(44)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
    }
    
    //        necessary for some random errors
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}





