//
//  ViewController.swift
//  fashion
//
//  Created by Tyler Shukert on 2017/10/05.
//  Copyright © 2017 Tyler Shukert. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController{

    var line: String? {
        didSet {
            navigationItem.title = line!
            
            let textView: UITextView = {
                let textView = UITextView()
                textView.text = line!
                textView.backgroundColor = UIColor.red
                return textView
            }()
            
            view?.addSubview(textView)
            view?.addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: textView)
            view?.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        

        setUpView()
    }
    
    func setUpView() {
        //setup for the name label
        let nameLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "something"
            label.backgroundColor = UIColor.red
            
            return label
        }()
        
        view?.addSubview(nameLabel)
        view?.addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: nameLabel)
        view?.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: nameLabel)

    }
    
}






