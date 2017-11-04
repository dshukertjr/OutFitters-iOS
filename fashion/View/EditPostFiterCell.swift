//
//  cells.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/16.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit
import LBTAComponents
import CoreImage

protocol EditPostFilterCellDelegate {
    func filterTapped(filterLabel: String, filterName: String)
}


//view for the home screen cell
class EditPostFilterCell: UICollectionViewCell {    
    
    var delegate: EditPostFilterCellDelegate?

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        
        self.setUpViews()

    }
    
    var filterLabel: String?
    var filterName: String?
    var filterLevel: Float?
    
    
    let filterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "status2")
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .red
        return imageView
    }()
    

    let filterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "something"
        label.textColor = UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        label.textAlignment = NSTextAlignment.center
//        label.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6)
//        label.textColor = .white
        return label
    }()
    

    func setUpViews() {
        
        //add tap gesture recognizer
        let filterGesture = UITapGestureRecognizer(target: self, action: #selector(self.setFilter(_:)))
        self.addGestureRecognizer(filterGesture)

        
        
        //adding filter image
        contentView.addSubview(filterImageView)
//        filterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        filterImageView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor).isActive = true
//        filterImageView.widthAnchor.constraint(equalToConstant: 60)
//        filterImageView.heightAnchor.constraint(equalToConstant: 60)
        filterImageView.anchor(nil, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
        //adding filter label
//        contentView.backgroundColor = .blue
        contentView.addSubview(filterNameLabel)
        filterNameLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //filtering the image
        if(filterName != "Normal") {
            
            // convert UIImage to CIImage
            let inputCIImage = CIImage(image: filterImageView.image!)!
            
            //filter processing
//            if(filterName != nil){
//                print("***", filterLabel!, filterName!)
//            }
            
            let filter = CIFilter(name: filterName!)!
            filter.setValue(inputCIImage, forKey: kCIInputImageKey)
            
            if(filterLabel == "Bright"){
//                filter.setValue(1.0, forKey: kCIInputSaturationKey)
                filter.setValue(0.05, forKey: kCIInputBrightnessKey)
//                filter.setValue(1.0, forKey: kCIInputContrastKey)
            }else if(filterLabel == "Soft") {
                filter.setValue(0.8, forKey: kCIInputSaturationKey)
//                filter.setValue(0, forKey: kCIInputBrightnessKey)
//                filter.setValue(1.0, forKey: kCIInputContrastKey)
            }else if(filterLabel == "Monotone") {
                filter.setValue(0.0, forKey: kCIInputSaturationKey)
//                filter.setValue(0, forKey: kCIInputBrightnessKey)
//                filter.setValue(1.0, forKey: kCIInputContrastKey)
            }else if(filterLabel == "Sepia") {
                filter.setValue(0.8, forKey: kCIInputAngleKey)
            }else if(filterLabel == "Sharp") {
//                filter.setValue(0.02, forKey: kCIInputNoiseLevelKey)
                filter.setValue(1, forKey: kCIInputSharpnessKey)
            }else if(filterLabel == "Morning") {
                //no parameters to change
            }else if(filterLabel == "Paint") {
                filter.setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
                filter.setValue(CIVector(x: 0.25, y: 0.5), forKey: "inputPoint1")
                filter.setValue(CIVector(x: 0.5, y: 0.5), forKey: "inputPoint2")
                filter.setValue(CIVector(x: 0.75, y: 0.75), forKey: "inputPoint3")
                filter.setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
            }else if(filterLabel == "") {
                
            }else if(filterLabel == "") {
                
            }else if(filterLabel == "") {
                
            }
            
            
            // Get the filtered output image and return it
            let outputImage = filter.outputImage!
            filterImageView.image =  UIImage(ciImage: outputImage)
            
        }

    }
    
    @objc func setFilter(_ sender: UITapGestureRecognizer) {
        print("set filter")
        delegate?.filterTapped(filterLabel: self.filterLabel!, filterName: self.filterName!)
    }
    
    
}
