//
//  MeetMonkeysController.swift
//  events.child.2
//
//  Created by Casey Colby on 7/20/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import UIKit

class MeetMonkeysController: UIViewController {
    
    @IBOutlet weak var OrangeMonkey: UIImageView!
    @IBOutlet weak var PurpleMonkey: UIImageView!
    @IBOutlet weak var gestureInstruction: UILabel!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var longPressRecognizer: UILongPressGestureRecognizer!
    
    //MARK: Variables
    
    var trial: Trial! //receives subject instance from WelcomeController

   
    

    
    //MARK: Actions
    
    @IBAction func beginGame(sender: UILongPressGestureRecognizer) {
        OrangeMonkey.hidden = false
        PurpleMonkey.hidden = false
        gestureInstruction.hidden = false
        gestureInstruction.text = "two-finger tap anywhere to continue"
        longPressRecognizer.enabled = false
        tapGestureRecognizer.enabled = true
        tapGestureRecognizer.numberOfTapsRequired = 2
        
    }
 
    
    
    
    
    
    //MARK: View Lifecycle
    
    // holding screen that requires long press to enter experiment so that we can set up the game and subject info before the subject arrives and leave it in this state until they're ready to participate
    override func viewDidLoad() {
        super.viewDidLoad()
        OrangeMonkey.hidden = true
        PurpleMonkey.hidden = true
        gestureInstruction.text = "press and hold to enter"
        gestureInstruction.hidden = false
        tapGestureRecognizer.enabled = false
        longPressRecognizer.enabled = true
    }
    
    
    
    
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navVC = segue.destinationViewController as! UINavigationController
        
        if let destination = navVC.viewControllers.first as? PlayVideoController {
            destination.trial = self.trial //pass subject instance to PlayVideoController
        }
    }
    
    
}


