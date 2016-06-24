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
    
    func coverBackground() {
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
        //launch screen y constraint should be -(115-86/2) = -72
        nuLogo.frame = CGRect(x: self.view.frame.width/2 - 455/2, y: self.view.frame.height/2 + 30, width: 455, height: 149)
        //w: 455, h: 149
        //launch screen y constraint should be +(30+149/2) = +104
        
        self.view.addSubview(cldlLogo)
        self.view.addSubview(nuLogo)
    }
    
    func backgroundFadeIn() {
        UIView.animateWithDuration(3.0, delay: 0.0, options: .CurveEaseOut, animations: {self.whiteView.alpha = 0}, completion: {_ in
            self.backgroundView = self.whiteView
            self.whiteView.removeFromSuperview()
            
            self.rotateLogos()
            self.squishLogos()
            self.fadeLogos()
            
            //segue after delay
            let seconds = 3.7
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                
                self.performSegueWithIdentifier("toWelcome", sender: self)
                
            })
        
            }
        )
    }
    
    func rotateLogos(){
        UIView.animateWithDuration(1.5, delay: 0.0, options: .CurveEaseInOut, animations: {self.cldlLogo.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))}, completion: nil)
         UIView.animateWithDuration(1.5, delay: 0.0, options: .CurveEaseInOut, animations: {self.nuLogo.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))}, completion: nil)

    }
    
    //MARK: Logo Animation
    
    func squishLogos(){
        UIView.animateWithDuration(0.7, delay: 3.0, options: .CurveEaseOut, animations: {
            self.cldlLogo.transform = CGAffineTransformMakeScale(1.25, 0.75)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 3.0, options: .CurveEaseOut, animations: {
            self.nuLogo.transform = CGAffineTransformMakeScale(1.25, 0.75)
            }, completion: nil)

    }
    
    func fadeLogos(){
        UIView.animateWithDuration(2.0, delay: 2.4, options: .CurveEaseInOut, animations: {self.cldlLogo.alpha = 0.0}, completion: {finished in
            self.cldlLogo.removeFromSuperview()})
        UIView.animateWithDuration(2.0, delay: 2.4, options: .CurveEaseInOut, animations: {self.nuLogo.alpha = 0.0}, completion: {finished in
            self.nuLogo.removeFromSuperview()})
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverBackground()
        includeLogos()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        backgroundFadeIn()
    }
}
