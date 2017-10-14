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
                textView.text = line
                return textView
            }()
            
            view?.addSubview(textView)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        

    }
    
}






