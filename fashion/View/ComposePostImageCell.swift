//
//  cells.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import LBTAComponents


//view for the home screen cell
class ComposePostImageCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let image = datasourceItem as? ComposePostImage else { return }
            
            if let postImage = image.postImage {
                postImageView.image = postImage
            }
        }
    }
    
    //set up for profile image view
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "sample")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        //        backgroundColor = .white
        
        //add sub views
        addSubview(postImageView)
        
        postImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

