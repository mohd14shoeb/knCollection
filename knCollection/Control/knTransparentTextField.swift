//
//  knTransparentTextField.swift
//  RewardShopr
//
//  Created by Ky Nguyen on 11/14/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class knTransparentTextField: UITextField {

    override var placeholder: String? {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder!,
                                                       attributes: [NSForegroundColorAttributeName: UIColor.black])
        }
    }
    
    var backgroundOpacity : CGFloat? = 1 {
        didSet {
            guard let opacity = backgroundOpacity else { return }
            backgroundColor = backgroundColor?.withAlphaComponent(opacity)
        }
    }
    
    var animationView : UIView?
    let animationDuration: Double = 0.25
    
    override func becomeFirstResponder() -> Bool {
        
        guard isFirstResponder == false else { return true }
        
        if backgroundOpacity != nil {
            addAnimationView()
            animateViewAppear()
        }
        super.becomeFirstResponder()
        return true
    }
    
    func addAnimationView() {
        animationView = UIView(frame: bounds)
        animationView?.frame.origin.x = -bounds.size.width
        animationView?.backgroundColor = backgroundColor?.withAlphaComponent(1)
        animationView?.alpha = 0
        addSubview(animationView!)
    }
    
    func animateViewAppear() {

        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn, animations: { [weak self] in

            self?.animationView?.alpha = 1
            self?.animationView?.frame.origin.x = 0
        })
    }
    
    override func resignFirstResponder() -> Bool {
        
        super.resignFirstResponder()
        
        guard backgroundOpacity != nil else { return true }
        if hasText {
            backgroundColor = backgroundColor?.withAlphaComponent(1)
            self.animationView?.removeFromSuperview()
            self.animationView = nil
        }
        else {
            backgroundColor = backgroundColor?.withAlphaComponent(backgroundOpacity!)
            animateViewDisappear()
        }

        return true
    }
    
    func animateViewDisappear() {
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            
            self.animationView?.alpha = 0
            self.animationView?.frame.origin.x = -self.bounds.size.width
            
        }, completion: { completed in
        
            self.animationView?.removeFromSuperview()
            self.animationView = nil
        })

    }    
}
