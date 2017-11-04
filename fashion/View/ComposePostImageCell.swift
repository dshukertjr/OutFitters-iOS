//
//  cells.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import LBTAComponents

//protocol for tapping the image of the cell
protocol ComposePostImageCellDelegate {
    func imageTapped(tappedImageView: ComposePostImageView)
}

//view for the home screen cell
class ComposePostImageCell: DatasourceCell {
    
    var delegate: ComposePostImageCellDelegate?
    
    override var datasourceItem: Any? {
        didSet {
            
            guard let image = datasourceItem as? ComposePostImageView else { return }

            postImageView.image = image.image
            postImageView.index = image.index

        }
    }
    
    lazy var postImageView: ComposePostImageView = {
        let imageView = ComposePostImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "sample")
        imageView.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickImage(_:)))
        tap.delegate = self as? UIGestureRecognizerDelegate
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    //function being executed when the user taps on the image
    @objc func pickImage(_ sender: UITapGestureRecognizer) {
        delegate?.imageTapped(tappedImageView: self.postImageView)
    }
    
    
    override func setupViews() {
        super.setupViews()
        //        backgroundColor = .white
        
        //add sub views
        addSubview(postImageView)
        
        postImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

