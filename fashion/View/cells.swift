//
//  cells.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import LBTAComponents
import FirebaseStorageUI


//view for the home screen cell
class HomeCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let post = datasourceItem as? Post else { return }
            profileImageView.image = #imageLiteral(resourceName: "profile1")
            nameLabel.text = post.userName
            statusTextView.text = post.statusText
//            statusImageView.image = #imageLiteral(resourceName: "status2")

            if let statusImageRef = post.statusImageRef {
                // Placeholder image
                let placeholderImage = UIImage(named: "status1")
                
                let storageRef = Storage.storage().reference()
                let reference = storageRef.child("posts/\(statusImageRef)")
                print("*** ref ", reference)
                
                statusImageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
            }
        }
    }
    
    
    //name label
    let nameLabel: UILabel = {
        let label = UILabel()
        //        label.backgroundColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "something"
        return label
    }()
    
    //set up for profile image view
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "sample")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //set up for status image view
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        //        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    //set up for status text view
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(white: 1, alpha: 0)
        //        textView.backgroundColor = .red
        textView.text = "mean while sometinghappen ed"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()

    
    override func setupViews() {
        super.setupViews()
//        backgroundColor = .white
        
        //add sub views
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(statusImageView)
        addSubview(statusTextView)
        
        
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 28, heightConstant: 28)
        nameLabel.anchor(nil, left: profileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 28)
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        //height of the image view is the same as the width: square image view
        statusImageView.anchor(profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: UIScreen.main.bounds.width)
        statusTextView.anchor(statusImageView.bottomAnchor, left: profileImageView.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)

    }
}
