//
//  KTextField.swift
//  kLibrary
//
//  Created by Ky Nguyen on 8/25/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class knUnderlineTextField: UITextField {

    fileprivate var underline : UIView!
    var underlineColor : UIColor! {
        willSet(value) {
            underline.backgroundColor = value
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupControl()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupControl()
    }
    
    func setupControl() {
        underline = UIView(frame: CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1))
        underline.translatesAutoresizingMaskIntoConstraints = true
        underline.autoresizingMask = [UIViewAutoresizing.flexibleWidth]
        addSubview(underline)
    }
    
    override func becomeFirstResponder() -> Bool {
        underline.backgroundColor =  underlineColor != nil ? underlineColor! : UIColor.darkGray
        super.becomeFirstResponder()
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        underline.backgroundColor = UIColor.lightGray
        super.resignFirstResponder()
        return true
    }

    

}

