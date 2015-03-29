//
//  MyCell.swift
//  MaterialKit
//
//  Created by Le Van Nghia on 11/16/14.
//  Copyright (c) 2014 Le Van Nghia. All rights reserved.
//

import UIKit

class MyCell : MKTableViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    
   
    override var layoutMargins: UIEdgeInsets {
        get { return UIEdgeInsetsZero }
        set(newVal) {}
    }
    
    func setMessage(message: String) {
        label.text = message
    }
    
}
