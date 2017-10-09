//
//  ViewController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/05.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit

class CustomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let customCellIdentifier = "customCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CustomCell
        customCell.nameLabel.text = names[indexPath.item]
        return customCell
    }
    
//    define the texts in the cell
    let names = ["mark", "stege", "something is wrong, help me, I am dying. I love this place so much I can shoot a basket ball over the wall"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        set the width and height of the cells
        return CGSize(width: view.frame.width, height: 200)
    }
    
    class CustomCell: UICollectionViewCell {
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "custom text"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
//        add subviews and add constraints
        func setupViews(){
            backgroundColor = UIColor.red
            addSubview(nameLabel)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        }
        
//        necessary for some random errors
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

}

