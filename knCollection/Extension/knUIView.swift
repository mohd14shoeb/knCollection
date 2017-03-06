//
//  UIView.swift
//  kLibrary
//
//  Created by Ky Nguyen on 8/27/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    
    func createBorder(_ width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func createRoundCorner(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func createCircleShape() {
        createRoundCorner(self.frame.size.width / 2)
    }
    
    func createImageFromView() -> UIImage {
        UIGraphicsBeginImageContext(bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func clearSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    func setupGradientLayer(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        gradientLayer.colors = colors.map({ (uiColor) -> CGColor in
            return uiColor.cgColor
        })
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addConstraint(attribute: NSLayoutAttribute, equalTo view: UIView, toAttribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        
        let myConstraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: view, attribute: toAttribute, multiplier: multiplier, constant: constant)
        return myConstraint
    }
    
    func addH_Constraint(toView view: UIView) {
        
        addConstraints(withFormat: "H:|[v0]|", views: view)
    }
    
    func addV_Constraint(toView view: UIView) {
        
        addConstraints(withFormat: "V:|[v0]|", views: view)
    }
    
    func addConstraints(withFormat format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for i in 0 ..< views.count {
            let key = "v\(i)"
            views[i].translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = views[i]
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 5, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 5, y: center.y))
        layer.add(animation, forKey: "position")
    }
    
}


extension UIView {
    
    @discardableResult
    public func left(toAnchor anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = leftAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func left(toView view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func right(toAnchor anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = rightAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func right(toView view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = rightAnchor.constraint(equalTo: view.rightAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func top(toAnchor anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func top(toView view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func bottom(toAnchor anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func bottom(toView view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func size(_ size: CGSize) {
        
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        
    }
    
    @discardableResult
    public func width(_ width: CGFloat) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func width(toDimension dimension: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func square() {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1, constant: 0).isActive = true 
    }
    
    
    @discardableResult
    public func width(toView view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func height(_ height: CGFloat) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func height(toDimension dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalTo: dimension, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func height(toView view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func centerX(toView view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func centerX(toAnchor anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func centerY(toView view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func centerY(toAnchor anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    
    @discardableResult
    public func horizontal(toView view: UIView, constant: CGFloat = 0) {
        
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).isActive = true
    }
    
    @discardableResult
    public func horizontal(toView view: UIView, leftPadding: CGFloat, rightPadding: CGFloat) {
        
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftPadding).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightPadding).isActive = true
    }
    
    @discardableResult
    public func vertical(toView view: UIView, constant: CGFloat = 0) {
        
        topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
    }
    
    @discardableResult
    public func vertical(toView view: UIView, topPadding: CGFloat, bottomPadding: CGFloat) {
        
        topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomPadding).isActive = true
    }
    
    
    
    
    
}
