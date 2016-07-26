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
    @IBOutlet weak var topView: UIView!
    
    
    
    
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
    
    
    
    
    
    //MARK: Stimuli/Videos
    
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
    
    //To play video via AVPlayerViewController
    func playVideo(){
        //setup
        path = videos[i] //access next video
        url = NSURL.fileURLWithPath(path as! String)
        item = AVPlayerItem (URL: url)
        
        //initialize AVPlayerVC
            //presenting as VC and not automatic subview bc we want ability to replay
        player = AVPlayer(playerItem: item)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        self.presentViewController(playerController, animated: true, completion: nil)
        
        //setup to get notification when video finished
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoDidFinish", name: AVPlayerItemDidPlayToEndTimeNotification, object: item)
        
        //play video automatically after a delay
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.player.play()
        }
       }

    func videoDidFinish(){
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC)) //slight delay needed
        dispatch_after(time, dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    //To play practice trials
    func playPracticeTrials() {
        let practice : [NSObject] = [
            NSBundle.mainBundle().pathForResource("Practice_A", ofType: "mov")!,
            NSBundle.mainBundle().pathForResource("practice_B", ofType: "mov")!]
        
        path = practice[n]
        url = NSURL.fileURLWithPath(path as! String)
        player = AVPlayer(URL: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true, completion: nil)
        
        //play video automatically after a delay
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.player.play()
        }
    }
    
    
    
    
    
    //MARK: Actions
    
    @IBAction func tapGestureReceived(sender: AnyObject) {
       if (n < 2) { //NUMBERofPRACTICETRIALS
//            playPracticeTrials()
            self.performSegueWithIdentifier("toResponse", sender: self)
       } else {
            selectStimuliOrder() //get correct stimuli
            if (i < videos.count) { //as long as remainint trials to show:
                playVideo()//show AVPlayerVC and play video
                newTrial() //create new db row and populate with video filename info and subject info
                self.performSegueWithIdentifier("toResponse", sender: self) //go to ResponseController (trigger segue when video closed)
            } else {
                self.performSegueWithIdentifier("toEndExperiment", sender: self) //if no more trials, show final screen (trigger segue when video closed)
            }
        }
    }

    func updateBananaScore() {
        let bananas = String(count: i, repeatedValue: Character("🍌"))
        bananaDisplay.text = bananas
    }
    
    
    
    
    
    //MARK: Realm

    //To add/write database object to the database
    func newTrial() {
        
        let fileName = url.URLByDeletingPathExtension?.lastPathComponent!
        let fileNameArr = fileName!.componentsSeparatedByString("_")
        
        let realm = try! Realm()
        
        try! realm.write {
            //1. set up new trial
            let newSubject = Subject() //get new instance of Subject model (new db row)
            
            newSubject.subjectNumber = subject.subjectNumber //populate fields of realm object
            newSubject.condition = subject.condition
            newSubject.order = order
            
            newSubject.trialNumber = i + 1
            
            realm.add(newSubject)
            self.subject = newSubject //assign to our subject variable to pass to ResponseController for updating
            
            //2. populate trial with info from filename
            subject.Anumber = fileNameArr[0]
            subject.Aheight = fileNameArr[1]
            subject.Aduration = fileNameArr[2]
            subject.Bnumber = fileNameArr[3]
            subject.Bheight = fileNameArr[4]
            subject.Bduration = fileNameArr[5]
            }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateBananaScore()
    }
}




