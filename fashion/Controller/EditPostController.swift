//
//  EditPostController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/29.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

//controller for after choosing image at composePostController

import UIKit
import LBTAComponents
import Firebase

class EditPostController: UIViewController, UITextViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, EditPostFilterCellDelegate {

    var chosenImage = UIImage()
        
    var collectionView: UICollectionView!
    
    var activeField: UITextView?
    
    var imageFilterCollectionViewContainer = UIView()
    
    var statusTextView = UITextView()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.isScrollEnabled = false
//        scrollView.backgroundColor = .yellow
        return scrollView
    }()
    
    //the buttons to toggle between status text and filter
    let showStatusButton: UIButton = {
        let button  = UIButton()
        button.setTitle("キャプション",for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let showFilterButton: UIButton = {
        let button  = UIButton()
        button.setTitle("フィルター",for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    //end setting the buttons to toggle between status text and filter

    let chosenImageView: UIImageView = {
        let imageView = UIImageView()
        //            imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
//        imageView.isUserInteractionEnabled = true
        return imageView
    }()


    
    override func viewDidLoad() {
        
        self.setupRightNavigationController()
        
        view.backgroundColor = .white
        
        navigationItem.title = "New Post"
        navigationController?.navigationBar.backgroundColor = .white

        let scrollView = self.scrollView

        view.addSubview(scrollView)

        scrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        //plain view directly inside the scroll view as a wrapper
        let contentView: UIView = {
            let contentView = UIView()
//            contentView.backgroundColor = .red
            return contentView
        }()
        
        scrollView.addSubview(contentView)
        
//        contentView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        contentView.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true

        
        
        
        
//        let toggleFilterTextStackView: UIView = {
//            let toggleView = UIView()
//            toggleView.backgroundColor = .red
//            return toggleView
//        }()
    
        
        let toggleFilterTextStackView: UIStackView = {
            let stackView = UIStackView()
//            stackView.backgroundColor = .red
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .center
//            stackView.spacing = 30.0
            return stackView
        }()
        
        let statusFilterContainer: UIView = {
            let container = UIView()
            return container
        }()
        
        chosenImageView.image = chosenImage


        statusTextView = {
            let textView = UITextView()
//            textView.backgroundColor = UIColor(white: 1, alpha: 0)
//            textView.backgroundColor = .red
            textView.font = UIFont.systemFont(ofSize: 14)
//            textView.isScrollEnabled = false
//            textView.isEditable = false
            textView.addDoneButton()
            textView.layer.borderColor = UIColor.gray.cgColor
            textView.layer.borderWidth = 0.5
            
            //for placeholder
            textView.text = "キャプションを書く"
            textView.textColor = UIColor.lightGray
            //end for placeholder
            
            return textView
        }()
        
        statusFilterContainer.addSubview(statusTextView)
        
        statusTextView.anchor(statusFilterContainer.topAnchor, left: statusFilterContainer.leftAnchor, bottom: statusFilterContainer.bottomAnchor, right: statusFilterContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        statusTextView.delegate = self

        
        contentView.addSubview(chosenImageView)
        contentView.addSubview(toggleFilterTextStackView)
        contentView.addSubview(statusFilterContainer)
        
//        scrollView.addSubview(chosenImageView)
//        scrollView.addSubview(toggleFilterTextView)
//        scrollView.addSubview(statusTextView)

//        view.addSubview(chosenImageView)
//        view.addSubview(toggleFilterTextView)
//        view.addSubview(statusTextView)

        
        
        toggleFilterTextStackView.anchor(nil, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        statusFilterContainer.anchor(nil, left: contentView.leftAnchor, bottom: toggleFilterTextStackView.topAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 120)
        
//        chosenImageView.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 2000)
        chosenImageView.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: statusFilterContainer.topAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

//        toggleFilterTextView.anchor(nil, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
//
//        statusTextView.anchor(nil, left: scrollView.leftAnchor, bottom: toggleFilterTextView.topAnchor, right: scrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 120)
//
//        chosenImageView.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: statusTextView.topAnchor, right: scrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//
//        toggleFilterTextView.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
//
//        statusTextView.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: toggleFilterTextView.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 120)
//
//        chosenImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: statusTextView.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)


        
        
        
        
        let statusGesture = UITapGestureRecognizer(target: self, action: #selector(activateStatusText(_:)))
        showStatusButton.addGestureRecognizer(statusGesture)
        
        let filterGesture = UITapGestureRecognizer(target: self, action: #selector(activateFilter(_:)))
        showFilterButton.addGestureRecognizer(filterGesture)


        
        //add the toggle filter status text buttons into the stack view
        toggleFilterTextStackView.addArrangedSubview(showStatusButton)
        toggleFilterTextStackView.addArrangedSubview(showFilterButton)

        
        
        
        
        
        
        
        
        //for filter collection view
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 120)
        //makes the cell spacing 0
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        
        let imageFilterCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        let imageFilterCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        imageFilterCollectionView.dataSource = self
        imageFilterCollectionView.delegate = self
        imageFilterCollectionView.register(EditPostFilterCell.self, forCellWithReuseIdentifier: "cell")
        imageFilterCollectionView.backgroundColor = .clear

        statusFilterContainer.addSubview(imageFilterCollectionViewContainer)
        imageFilterCollectionViewContainer.addSubview(imageFilterCollectionView)

        imageFilterCollectionViewContainer.anchor(statusFilterContainer.topAnchor, left: statusFilterContainer.leftAnchor, bottom: statusFilterContainer.bottomAnchor, right: statusFilterContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        imageFilterCollectionView.anchor(imageFilterCollectionViewContainer.topAnchor, left: imageFilterCollectionViewContainer.leftAnchor, bottom: imageFilterCollectionViewContainer.bottomAnchor, right: imageFilterCollectionViewContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        imageFilterCollectionViewContainer.isHidden = true
        
        //end for filter collection view
        
        
        //listening to keyboard show and hide
//        registerForKeyboardNotifications


    }

    
    
    
    
    
    @objc func activateStatusText(_ sender: UITapGestureRecognizer) {
        print("status text activated")
        showStatusButton.setTitleColor(.black, for: .normal)
        showFilterButton.setTitleColor(.lightGray, for: .normal)
        statusTextView.isHidden = false
        imageFilterCollectionViewContainer.isHidden = true
    }
    
    @objc func activateFilter(_ sender: UITapGestureRecognizer) {
        print("filter activated")
        showStatusButton.setTitleColor(.lightGray, for: .normal)
        showFilterButton.setTitleColor(.black, for: .normal)
        statusTextView.isHidden = true
        imageFilterCollectionViewContainer.isHidden = false
    }
    
    
    
    
    //filter selected
    func filterTapped(filterLabel: String, filterName: String) {
        print("filter tapped")
        self.filterImage(filterLabel: filterLabel, filterName: filterName)
    }
    
    func filterImage(filterLabel: String, filterName: String) {
        print(filterLabel, filterName)
        if(filterLabel == "Normal"){
            
            self.chosenImageView.image = self.chosenImage
            
        }else {
            
            
            // convert UIImage to CIImage
            let inputCIImage = CIImage(image: self.chosenImage)!
            
            //filter processing
            //            if(filterName != nil){
            //                print("***", filterLabel!, filterName!)
            //            }
            
            if let filter = CIFilter(name: filterName) {
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
                self.chosenImageView.image =  UIImage(ciImage: outputImage)
//                chosenImageView.contentMode = .scaleAspectFit
            }
            
        }
    }

    
    
    
    
    
    
    //for placeholder text and scrolling to avoide key board covering the content
    func textViewDidBeginEditing(_ textView: UITextView) {
        //for keyboard scroll
        scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)

        print("began editing")
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //for keyboard scroll
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        print("finished editing")
        if textView.text.isEmpty {
            textView.text = "キャプションを書く"
            textView.textColor = .lightGray
        }
    }
    //end for placeholder text

    
    
    
    
    //for filter collection view
    
    let filterNames = CIFilter.filterNames(inCategories: nil)
    
    let filters = [
        ImageFilter(label: "Normal", name: "Normal", level: 1.0),
        ImageFilter(label: "Bright", name: "CIColorControls", level: 8.0),
        ImageFilter(label: "Soft", name: "CIColorControls", level: 0.0),
        ImageFilter(label: "Monotone", name: "CIColorControls", level: 1.0),
        ImageFilter(label: "Sepia", name: "CIHueAdjust", level: 1.0),
        ImageFilter(label: "Sharp", name: "CINoiseReduction", level: 1.0),
        ImageFilter(label: "Morning", name: "CILinearToSRGBToneCurve", level: 1.0),
        ImageFilter(label: "Paint", name: "CIToneCurve", level: 1.0),
        ImageFilter(label: "", name: "Normal", level: 1.0),
        ImageFilter(label: "", name: "Normal", level: 1.0)]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.size.height)
    }
    
    //function to resize image
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! EditPostFilterCell
        
        cell.filterNameLabel.text = self.filters[indexPath.row].label
        
        cell.filterImageView.image = self.resizeImage(image: self.chosenImage, newWidth: 200)
        
        cell.filterLabel = self.filters[indexPath.row].label
        
        cell.filterName = self.filters[indexPath.row].name
        
        cell.filterLevel = self.filters[indexPath.row].level
        
        //need to set the delegate to self in order for the filterTap function to work
        cell.delegate = self
        
        cell.awakeFromNib()

//        cell.backgroundColor = .red
        return cell
    }
    //end for filter collection view
    
    

    
    
    
    
    
    
    //submitting the post
    @objc func submitPost(_ sender: UITapGestureRecognizer) {
        print("submit post called")
        self.submitToDataBase()
//        self.submitToStorage(imageName: "some.png")
    }
    
    func submitToStorage(imageName: String) {
        
        print("image width: ", self.chosenImageView.image!.size.width, "image height: ", self.chosenImageView.image!.size.height)
        
        print("image scale", self.chosenImageView.image!.scale)
        
        let storageRef = Storage.storage().reference().child("posts/").child(imageName)
        
        UIGraphicsBeginImageContext(CGSize(width: 640, height: 640))
        chosenImageView.image!.draw(in: CGRect(x: 0, y: 0, width: 640, height: 640))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        if let uploadData = UIImagePNGRepresentation(newImage!) {
            
            storageRef.putData(uploadData, metadata: nil, completion: {(metadata, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if metadata != nil {
                    print(metadata!)
                }else {
                    print("meta data is nil")
                }
            })
        }
    }
    
    func submitToDataBase() {
        //go to the home tab
        func openHomeTab() {
            print("open home tab called")
            self.tabBarController?.selectedIndex = 0
        }
        
        //dismiss the current view controller
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: {
            openHomeTab()
        })

        let db = Firestore.firestore()
        
        let postRef = db.collection("posts").document()
        
        var statusText = self.statusTextView.text as String
        if(self.statusTextView.textColor == .lightGray) {
            statusText = ""
        }
        let statusImage = (postRef.documentID as String) + ".png"
        
        print("postRef", postRef)
        
        postRef.setData([
            "statusText": statusText,
            "statusImage": statusImage
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                
                print("Successfully submitted status text")
                self.submitToStorage(imageName: statusImage)

            }
        }
    }
    //end submitting the psot
    
    
    
    func setupRightNavigationController() {
        //populate the left side of the navigation bar
        let submitButton = UIButton(type: .system)
        //with rendering mode is to maintain the original color of the image
        submitButton.setImage(#imageLiteral(resourceName: "tabMessage").withRenderingMode(.alwaysOriginal), for: .normal)
        submitButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: submitButton), UIBarButtonItem(customView: submitButton)]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(submitPost(_:)))
        submitButton.addGestureRecognizer(tapGesture)
    }

    
}


extension UITextView {
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: self, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
}


//struct for list of filters
struct ImageFilter {
    var label: String?
    var name: String?
    var level: Float?
    
    init(label: String, name: String, level: Float) {
        self.label = label
        self.name = name
        self.level = level
    }
}
