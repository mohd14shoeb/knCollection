//
//  CircleCharacterView.swift
//  CharacterAvatar
//
//  Created by Ky Nguyen on 5/24/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class CircleCharacterView: UIView {

    var character: String! {
        willSet (value) {
            createCircleAvatarFromCharacter(value)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    override init(frame: CGRect) { super.init(frame: frame) }
    
    convenience init(frame: CGRect, character: String) {
        
        self.init(frame: frame)
        createCircleAvatarFromCharacter(character)
    }
    
    func createCircleAvatarFromCharacter(_ c: String) {
    
        let label = UILabel(frame: frame)
        label.text = c
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.frame.origin = CGPoint(x: 0, y: 0)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: frame.size.width / 2)
        addSubview(label)
        
        layer.cornerRadius = frame.width / 2
        backgroundColor = randomColor()
    }

    func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(150)) / 255
        let g = CGFloat(arc4random_uniform(150)) / 255
        let b = CGFloat(arc4random_uniform(150)) / 255
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
