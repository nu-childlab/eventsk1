//
//  InitialViewController.swift
//  events.child.2
//
//  Created by Casey Colby on 6/19/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import UIKit

class InitialViewController : UIViewController {
    
    var whiteView: UIView!
    var cldlLogo: UIImageView!
    var nuLogo: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    func hideBackground() {
        whiteView = UIView(frame: self.view.frame)
        whiteView.backgroundColor = UIColor.whiteColor()
        whiteView.alpha = 1
        view.insertSubview(whiteView, aboveSubview: backgroundView)
    }
    
    func includeLogos() {
        cldlLogo = UIImageView(image: (UIImage(named: "ChiLDyB02.png")))
        nuLogo = UIImageView(image: (UIImage(named: "NULing.png")))
        
        cldlLogo.frame = CGRect(x: self.view.frame.width/2 - 455/2, y: self.view.frame.height/2 - 115, width: 455, height: 86)
        //w: 455, h: 86
        nuLogo.frame = CGRect(x: self.view.frame.width/2 - 455/2, y: self.view.frame.height/2 + 30, width: 455, height: 149)
        //w: 455, h: 149
        
        self.view.addSubview(cldlLogo)
        self.view.addSubview(nuLogo)
    }
    
    func backgroundFadeIn() {
        UIView.animateWithDuration(5.0, delay: 3.0, options: .CurveEaseOut, animations: {self.whiteView.alpha = 0}, completion: {_ in
            self.backgroundView = self.whiteView
            self.whiteView.removeFromSuperview()
            
            //segue after delay
            let seconds = 2.5
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                
                self.performSegueWithIdentifier("toWelcome", sender: self)
                
            })
        
            }
        )
        
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackground()
        includeLogos()
        print("HI CASEY FROM GIT")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        backgroundFadeIn()
    }
}
