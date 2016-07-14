//
//  PlayVideoController.swift
//  events.child.2
//
//  Created by Casey Colby on 4/20/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import UIKit
import RealmSwift
import AVKit
import AVFoundation

class PlayVideoController : UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var bananaDisplay: UILabel!
    
    //MARK: Variables
    
    //Subject instance passed from WelcomeController
    var subject: Subject!
    
    //Initialize array for stimuli
    var videos: [NSObject]!

    //Counter for array index (TRIALNUMBER)
    var i: Int = 0
    
    //counter for practice trials
    var n: Int = 0
    
    //Var used to specify stimuli order
    var order: Int!
    
    //Variables for video functions
    var path: NSObject!
    var url: NSURL!
    var item: AVPlayerItem!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var playerController: AVPlayerViewController!
    
    //MARK: Actions
    
    //To select ordered stimuli
    func selectStimuliOrder() {
        
        let lastCh = subject.subjectNumber[subject.subjectNumber.endIndex.predecessor()]//last character of subject number
        let odds : [Character] = ["1", "3", "5", "7", "9"]
        
        //stimuli arrays, 2 orders
        let orderA:[NSObject] = [
            NSBundle.mainBundle().pathForResource("4_400_6_3_800_4", ofType: "mov")!, //2
            NSBundle.mainBundle().pathForResource("2_800_6_4_600_4", ofType: "mov")!, //5
            NSBundle.mainBundle().pathForResource("3_800_4_4_400_6", ofType: "mov")!, //1
            NSBundle.mainBundle().pathForResource("3_400_8_2_800_6", ofType: "mov")!, //4
            NSBundle.mainBundle().pathForResource("4_400_6_2_600_8", ofType: "mov")!, //8
            NSBundle.mainBundle().pathForResource("4_600_4_2_800_6", ofType: "mov")!, //6
            NSBundle.mainBundle().pathForResource("2_800_6_3_400_8", ofType: "mov")!, //3
            NSBundle.mainBundle().pathForResource("2_600_8_4_400_6", ofType: "mov")!] //7

        let orderB:[NSObject] = [
            orderA[7], //7
            orderA[2], //1
            orderA[0], //2
            orderA[6], //3
            orderA[5], //6
            orderA[1], //5
            orderA[4], //8
            orderA[3]] //4
    
        //Alternate order value by odd/even subject number
        if odds.contains(lastCh){
            order = 0
        } else {
            order = 1
        }
        //Switch stimuli array and update DB based on order value
        switch order {
            case 0:
            videos = orderA
            case 1:
            videos = orderB
            default:
            videos = orderA
        }
    }
    
    //To show still image of monkeys in childVC, to be called the first time this view loads
    func meetMonkeys(){
        
        
        //initialize AVPlayerVC
        //presenting as VC and not automatic subview bc we want ability to replay
        player = AVPlayer(URL: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true, completion: nil)
        
        player.play()
    }
    
    //To play video via AVPlayerViewController (PlayerLayer was too glitchy and slow)
    func playVideo(){
        //setup
        path = videos[i] //access next video
        url = NSURL.fileURLWithPath(path as! String)
        //item = AVPlayerItem (URL: url)
        
        //initialize AVPlayerVC
            //presenting as VC and not automatic subview bc we want ability to replay
        player = AVPlayer(URL: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true, completion: nil)
        
        player.play()
       }
    
    //To play practice trials
    func practiceTrials() {
        let practice : [NSObject] = [
            NSBundle.mainBundle().pathForResource("Practice_A", ofType: "mov")!,
            NSBundle.mainBundle().pathForResource("practice_B", ofType: "mov")!]
        
        path = practice[n]
        url = NSURL.fileURLWithPath(path as! String)
        player = AVPlayer(URL: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true, completion: nil)
        
        player.play()
    }
    
    //To populate database with #s,heights,durations in video filename. Could be achieved more concisely but I think this is more intuitive. 
    func newTrial() {
        let fileName = url.URLByDeletingPathExtension?.lastPathComponent!
        let fileNameArr = fileName!.componentsSeparatedByString("_")
        
        let realm = try! Realm()
        
        try! realm.write {
            //1. set up new trial
            let newSubject = Subject() //get new instance of Subject model (new db row)
            
            newSubject.subjectNumber = subject.subjectNumber //populate fields
            newSubject.condition = subject.condition
            
            subject.order = order
            newSubject.order = subject.order
            
            newSubject.trialNumber = i + 1
            
            realm.add(newSubject)
            self.subject = newSubject //assign to our subject variable to pass to responseVC for updating
            
            //2. populate trial with info from filename
            subject.Anumber = fileNameArr[0]
            subject.Aheight = fileNameArr[1]
            subject.Aduration = fileNameArr[2]
            subject.Bheight = fileNameArr[3]
            subject.Bnumber = fileNameArr[4]
            subject.Bduration = fileNameArr[5]
            }
    }
    

    
    @IBAction func tapGestureReceived(sender: AnyObject) {
       if (n < 2) { //NUMBERofPRACTICETRIALS
            practiceTrials()
        self.performSegueWithIdentifier("toResponse", sender: self)
       } else {
            selectStimuliOrder() //1
            if (i < videos.count) { //2
                playVideo()//3
                newTrial() //4
                self.performSegueWithIdentifier("toResponse", sender: self) //5
            } else {
                self.performSegueWithIdentifier("endExperiment", sender: self) //6
            }
        }
    }
    /*
     1 - get correct stimuli
     2 - as long as there are remaining trials to show
     3 - show AVPlayerVC and play video
     4 - create new db row and populate with video filename info and subject info
     5 - go to ResponseController (trigger segue when video is closed)
     
     6 - if no more trials, show the final screen (trigger segue when video closed)
     */

    //keep banana score
    func updateBananaScore() {
        let bananas = String(count: i, repeatedValue: Character("🍌"))
        bananaDisplay.text = bananas
    }
    
    //MARK: Navigation
    
    //pass the subject (database) instance to ResponseController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if let destination = segue.destinationViewController as? ResponseController {
            destination.subject = self.subject
            destination.i = self.i
            destination.n = self.n
        }
    }
    

    //used to create unwind segue from response controller
    @IBAction func unwindToPlayVideo (segue: UIStoryboardSegue) {
    }
    
    
    //MARK: View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateBananaScore()
    }


}




