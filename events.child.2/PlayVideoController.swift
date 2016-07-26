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
    var p: Int = 0
    
    //Var used to specify stimuli order
    var order: Int!
    
    //Variables for video functions
    var path: NSObject!
    var url: NSURL!
    var item: AVPlayerItem!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var playerController: AVPlayerViewController!
    
    //Stimuli
    let practiceVideos: [NSObject] = [
        NSBundle.mainBundle().pathForResource("Practice_A", ofType: "mov")!,
        NSBundle.mainBundle().pathForResource("practice_B", ofType: "mov")!]
    
    let order1:[NSObject] = [
            NSBundle.mainBundle().pathForResource("4_400_6_3_800_4", ofType: "mov")!, //2
            NSBundle.mainBundle().pathForResource("2_800_6_4_600_4", ofType: "mov")!, //5
            NSBundle.mainBundle().pathForResource("3_800_4_4_400_6", ofType: "mov")!, //1
            NSBundle.mainBundle().pathForResource("3_400_8_2_800_6", ofType: "mov")!, //4
            NSBundle.mainBundle().pathForResource("4_400_6_2_600_8", ofType: "mov")!, //8
            NSBundle.mainBundle().pathForResource("4_600_4_2_800_6", ofType: "mov")!, //6
            NSBundle.mainBundle().pathForResource("2_800_6_3_400_8", ofType: "mov")!, //3
            NSBundle.mainBundle().pathForResource("2_600_8_4_400_6", ofType: "mov")!] //7
    
    
    
    
    //MARK: Videos/Stimuli 
    
    func selectStimuliOrder() {
        //alternate order
           let order2:[NSObject] = [
            order1[7], //7
            order1[2], //1
            order1[0], //2
            order1[6], //3
            order1[5], //6
            order1[1], //5
            order1[4], //8
            order1[3]] //4

        let lastCh = subject.subjectNumber[subject.subjectNumber.endIndex.predecessor()]//last character of subject number
        let evens : [Character] = ["0", "2", "4", "6", "8"]
    
        //Order det. by ODD/EVEN subj#
        if evens.contains(lastCh){
            order = 2
            videos = order2
        } else { //odds and default
            order = 1
            videos = order1
        }
    }
    
    func playVideo(index: Int, array: [NSObject]){
        //setup
        //path = videos[i] 
        path = array[index]
        url = NSURL.fileURLWithPath(path as! String)
        print(url)
        item = AVPlayerItem (URL: url)
        player = AVPlayer(playerItem: item)
        
        //display the player content
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        
        self.presentViewController(playerController, animated: true, completion: nil)
        
        //setup to get notification when video finished
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayVideoController.videoDidFinish), name: AVPlayerItemDidPlayToEndTimeNotification, object: item)
        
        //play after delay
        let wait = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(wait, dispatch_get_main_queue()) {
            self.player.play()
        }
       }
    
       func videoDidFinish(){
        let wait = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC)) //slight delay needed
        dispatch_after(wait, dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    
    
    //MARK: Actions
    
    @IBAction func tapGestureReceived(sender: AnyObject) {
       if (p < practiceVideos.count) {
            playVideo(p, array: practiceVideos)
            self.performSegueWithIdentifier("toResponse", sender: self)
       } else {
            selectStimuliOrder()
            if (i < videos.count) { //while trials remaining
                playVideo(i, array: videos)
                newTrial() //create new db row, populate with video filename info and subject info
                self.performSegueWithIdentifier("toResponse", sender: self)
            } else {
                self.performSegueWithIdentifier("toEndExperiment", sender: self) //if no more trials, show final screen
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
            destination.p = self.p
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




