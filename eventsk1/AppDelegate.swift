//
//  AppDelegate.swift
//  events.child.2
//
//  Created by Casey Colby on 4/20/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let skyblue = UIColor(red: 102/255, green: 204/255 ,blue: 255/255,alpha: 1)
        let aquablue = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
        
        UITextField.appearance().tintColor = skyblue
        UITextView.appearance().tintColor = skyblue
        self.window?.tintColor = aquablue //tint interactive elements like alert controller
        self.window?.backgroundColor = UIColor.blackColor()
        return true
    }
}

extension UINavigationController {
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        let skyblue = UIColor(red: 102/255, green: 204/255 ,blue: 255/255,alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:skyblue] //navigation bar title/prompt text color
        return .Default
    }
    
}

