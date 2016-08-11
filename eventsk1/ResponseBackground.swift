//
//  ResponseBackground.swift
//  events.child.2
//
//  Created by Casey Colby on 5/30/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//


/* symmetrical gradient so there's no chance of biasing kids towards one monkey over another as the correct answer
 */


import UIKit

@IBDesignable

class ResponseBackground: UIView {
    
    @IBInspectable var white: UIColor = UIColor.whiteColor()
    @IBInspectable var semiWhite: UIColor = UIColor(red: 255/255, green: 255/255, blue:255/255,alpha: 0.6)
    @IBInspectable var skyblue: UIColor = UIColor(red: 102/255, green:204/255, blue: 255/255, alpha:1)
    @IBInspectable var grey: UIColor = UIColor(red: 170/255, green:170/255, blue:170/255, alpha:0.6)
    @IBInspectable var grassgreen: UIColor = UIColor(red: 138/255, green:255/255, blue:127/255, alpha:1)
    @IBInspectable var clear: UIColor = UIColor.clearColor()
    
    override func drawRect(rect: CGRect) {
        
        
        let currentContext = UIGraphicsGetCurrentContext()
        
        let shadows1 = [semiWhite.CGColor, clear.CGColor, clear.CGColor, grey.CGColor]
        let shadows2 = [semiWhite.CGColor, clear.CGColor, clear.CGColor, grey.CGColor]
        let colors = [grassgreen.CGColor, skyblue.CGColor, white.CGColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 0.7, 1.0]
        let shadowLocations: [CGFloat] = [0.0, 0.55, 0.82, 1.0]
        
        let colorGradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        let shadowGradient = CGGradientCreateWithColors(colorSpace, shadows1, shadowLocations)
        let shadowGradient2 = CGGradientCreateWithColors(colorSpace, shadows2, shadowLocations)
        
        let bottomRight = CGPoint(x: self.bounds.width, y:self.bounds.height)
        let topLeft = CGPoint.zero
        let topRight = CGPoint(x: self.bounds.width, y:0)
        let bottomLeft = CGPoint(x: 0, y:self.bounds.height)
        
        CGContextDrawLinearGradient(currentContext, colorGradient, bottomRight, topRight, [])
        CGContextDrawLinearGradient(currentContext, shadowGradient, topLeft, bottomRight, [])
        CGContextDrawLinearGradient(currentContext, shadowGradient2, topRight, bottomLeft, [])
    }
    
}
