//
//  knCircleProcessView.swift
//  kynguyenCodebase
//
//  Created by Ky Nguyen on 9/16/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class knCircleProgressView: UIView {

    struct ColorPalette {
        static let teal = UIColor(red:0.27, green:0.80, blue:0.80, alpha:1.0)
        static let orange = UIColor(red:0.90, green:0.59, blue:0.20, alpha:1.0)
        static let pink = UIColor(red:0.98, green:0.12, blue:0.45, alpha:1.0)
    }
    
    fileprivate let progressLayer = CAShapeLayer()
    fileprivate let gradientLayer = CAGradientLayer()
    
    var range: CGFloat = 128
    var currentValue: CGFloat = 0 {
        didSet {
            animateStroke()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayers()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupLayers()
    }
    
    fileprivate func setupLayers() {
        
        setupProcessShape()
        layer.addSublayer(progressLayer)
        
        setupGradientProcess()
        layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupProcessShape() {
        progressLayer.position = CGPoint.zero
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = 0.0
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.black.cgColor
        
        let radius = CGFloat(bounds.height / 2) - progressLayer.lineWidth
        let path = createProcessPath(radius: radius)
        progressLayer.path = path.cgPath
    }
    
    fileprivate func createProcessPath(radius: CGFloat) -> UIBezierPath {
        
        let startAngle = CGFloat(-M_PI / 2)
        let endAngle = CGFloat(3 * M_PI / 2)
        let width = bounds.width
        let height = bounds.height
        let modelCenter = CGPoint(x: width / 2, y: height / 2)
        return UIBezierPath(arcCenter: modelCenter,
                            radius: radius,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: true)
    }
    
    fileprivate func setupGradientProcess() {
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height)
        gradientLayer.colors = [ColorPalette.teal.cgColor, ColorPalette.orange.cgColor, ColorPalette.pink.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.mask = progressLayer
    }
    
    fileprivate func animateStroke() {
        let fromValue = progressLayer.strokeEnd
        let toValue = currentValue / range
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        progressLayer.add(animation, forKey: "stroke")
        progressLayer.strokeEnd = toValue
    }
    
}

