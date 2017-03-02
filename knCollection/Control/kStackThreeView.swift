//
//  StackThreeView.swift
//  RewardShopr
//
//  Created by Ky Nguyen on 11/9/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class StackThreeView : UIView {
    
    let shapeContainerView: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let offset : CGPoint = CGPoint(x: 0, y: 20)
    private var size: CGSize? = nil
    private var colors: [UIColor] = [.red, .green, .blue]
    private var distance: CGFloat = 8
    private var radius : CGFloat = 6
    private var shouldRelayoutLayers = true
    
    init(distance: CGFloat = 8, cornerRadius: CGFloat = 6, colors: [UIColor] = [.red, .green, .blue]) {
        super.init(frame: .zero)
        storeParameters(distance: distance, cornerRadius: cornerRadius, colors: colors)
        
        addSubview(shapeContainerView)
        addConstraints(withFormat: "H:|[v0]|", views: shapeContainerView)
        addConstraints(withFormat: "V:|[v0]|", views: shapeContainerView)
    }
    
    private func storeParameters(distance: CGFloat = 8, cornerRadius: CGFloat = 6, colors: [UIColor] = [.red, .green, .blue]) {
        
        self.colors = colors
        self.distance = distance
        self.radius = cornerRadius
    }
    
    private func generateStackLayers(size: CGSize? = nil) {
        
        let color = colors[0]
        let color2 = colors[1]
        let color3 = colors[2]
        
        var layerSize = frame.size
        layerSize = CGSize(width: layerSize.width - offset.x, height: layerSize.height - offset.y)
        
        let offsetStep1: CGFloat = distance
        let offsetStep2 : CGFloat = offsetStep1 * 2
        let sizeStep1: CGFloat = offsetStep1 * 2
        let sizeStep2: CGFloat = offsetStep2 * 2
        
        let smallestShapeLayer = generateLayer(at: CGPoint(x: offset.x + offsetStep2, y: offset.y - offsetStep2),
                                               size: CGSize(width: layerSize.width - sizeStep2, height: layerSize.height - sizeStep2),
                                               cornerRadius: radius,
                                               color: color3)
        shapeContainerView.layer.addSublayer(smallestShapeLayer)
        
        let mediumShapeLayer = generateLayer(at: CGPoint(x: offset.x + offsetStep1, y: offset.y - offsetStep1),
                                             size: CGSize(width: layerSize.width - sizeStep1, height: layerSize.height - sizeStep1),
                                             cornerRadius: radius,
                                             color: color2)
        shapeContainerView.layer.addSublayer(mediumShapeLayer)
        
        let biggestShapeLayer = generateLayer(at: CGPoint(x: offset.x, y: offset.y),
                                              size: CGSize(width: layerSize.width, height: layerSize.height),
                                              cornerRadius: radius,
                                              color: color)
        shapeContainerView.layer.addSublayer(biggestShapeLayer)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSublayers(of: layer)
        shapeContainerView.layer.sublayers?.removeAll()
        generateStackLayers()
        shapeContainerView.layer.zPosition = 0
    }
    
    private func generateLayer(at offset: CGPoint, size: CGSize, cornerRadius: CGFloat, color: UIColor) -> CALayer {
        
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: offset.x,
                                                              y: offset.y,
                                                              width: size.width,
                                                              height: size.height),
                                          cornerRadius: cornerRadius)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = rectanglePath.cgPath
        shapeLayer.fillColor = color.cgColor
        return shapeLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

