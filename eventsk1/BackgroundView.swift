//
//  BackgroundView.swift
//  events.child.2
//
//  Created by Casey Colby on 5/28/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import UIKit

@IBDesignable

class BackgroundView: UIView {
    
    @IBInspectable var white: UIColor = UIColor.whiteColor()
    @IBInspectable var skyblue: UIColor = UIColor(red: 102/255, green:204/255, blue: 255/255, alpha:1)
    @IBInspectable var black: UIColor = UIColor.blackColor()
    @IBInspectable var black2: UIColor = UIColor.blackColor()
    @IBInspectable var grassgreen: UIColor = UIColor(red: 138/255, green:255/255, blue:127/255, alpha:1)
    @IBInspectable var clear: UIColor = UIColor.clearColor()
    
    
    override func drawRect(rect: CGRect) {
        
        
        let currentContext = UIGraphicsGetCurrentContext()
        
        let colors = [white.CGColor, skyblue.CGColor, black.CGColor]
        let colors2 = [black2.CGColor, clear.CGColor]
        let colors3 = [grassgreen.CGColor, clear.CGColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 0.6, 1.0]
        
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        let gradient2 = CGGradientCreateWithColors(colorSpace, colors2, colorLocations)
        let gradient3 = CGGradientCreateWithColors(colorSpace, colors3, colorLocations)
        
        
        let bottomRight = CGPoint(x: self.bounds.width, y:self.bounds.height)
        let topLeft = CGPoint.zero
        let topRight = CGPoint(x: self.bounds.width, y:0)
        let bottomLeft = CGPoint(x: 0, y:self.bounds.height)
        
        
        CGContextDrawLinearGradient(currentContext, gradient, topLeft, bottomRight, [])
        CGContextDrawLinearGradient(currentContext, gradient2, topRight, bottomLeft, [])
        CGContextDrawLinearGradient(currentContext, gradient3, bottomRight, topRight, [])
    }

}
