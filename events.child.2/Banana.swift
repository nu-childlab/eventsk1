//
//  Banana.swift
//  events.child.2
//
//  Created by Casey Colby on 8/4/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import UIKit

class Banana: UILabel  {
    
  
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        self.commonInit()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.commonInit()
    }
    
//    init(frame:CGRect, xcenter: CGFloat, ycenter: CGFloat) {
//        super.init(frame:frame)
//        self.commonInit()
//        self.setCenter(xcenter, ycenter: ycenter)
//    }

    
    func commonInit() {
        self.text = "🍌"
        self.font = font.fontWithSize(80)
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }

    
    func setCenter(xcenter: CGFloat, ycenter: CGFloat) {
        self.center = CGPointMake(xcenter,ycenter)
    }
    

    
    
    
}