//
//  ResponseController.swift
//  events.child.2
//
//  Created by Casey Colby on 4/22/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import UIKit
import RealmSwift

class ResponseController : UIViewController {
    
    //outlets
    @IBOutlet weak var monkey1: UIButton!
    @IBOutlet weak var monkey2: UIButton!
    @IBOutlet weak var advanceWithout: UIButton!
    
    
    
    
    
    //MARK: Variables
    
    //animation completion vars
    var t : Int = 1
    var timer: NSTimer!
    var posn : [CGFloat] = [CGFloat(0)]
    
    //banana vars
    lazy var leftBanana: UILabel = {
        let leftBanana = UILabel(frame: CGRect(x: 0,y: 0,width: 100.0, height: 100.0))
        leftBanana.text = "🍌"
        leftBanana.font = leftBanana.font.fontWithSize(80)
       // values for ranges and random points over monkeys
        let midpt = self.view.frame.size.width/2
        let monkeyWidth = self.monkey1.frame.size.width
        let rangeSize = UInt32(monkeyWidth)
        let leftRangeStart = midpt - 200 - monkeyWidth/2 //monkey centers + or - 200 from midpoint
        let leftRand = leftRangeStart + CGFloat(arc4random_uniform(rangeSize))
        leftBanana.center = CGPointMake(leftRand, 0)
        return leftBanana
    }()
    
    lazy var rightBanana: UILabel = {
        let rightBanana = UILabel(frame: CGRect(x: 0, y: 0, width: 100.0, height: 100.0))
        let midpt = self.view.frame.size.width/2
        let monkeyWidth = self.monkey1.frame.size.width
        let rangeSize = UInt32(monkeyWidth)
        let rightRangeStart = midpt + 200 - monkeyWidth/2 //monkey centers + or - 200 from midpoint
        let rightRand = rightRangeStart + CGFloat(arc4random_uniform(rangeSize)) //right half:start at midpoint//right half:start at midpoint
        rightBanana.center = CGPointMake(rightRand, 0)
        rightBanana.text = "🍌"
        rightBanana.font = rightBanana.font.fontWithSize(80)
        return rightBanana
    }()
    
    lazy var centerBanana: UILabel = {
        let centerBanana = UILabel(frame: CGRect(x: 0, y:0, width: 100.0, height: 100.0))
        centerBanana.center = CGPointMake (self.view.frame.size.width/2, 0)
        centerBanana.text = "🍌"
        centerBanana.font = centerBanana.font.fontWithSize(78)
        return centerBanana
    } ()
    
    var bananas: UIView! //left or right banana physics
    
    //db vars
    var subject: Subject! //passed from PVController
    var selectedButton: String!
    var i: Int = 0 //trial# / stimuli index; passed from PVController
    var totalTrials = 8 //CHANGE DEPENDING ON NUMBER OF TRIALS
    var p: Int = 0 //practice trial index, passed from PVController
      
    //physics properties
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var elasticity: UIDynamicItemBehavior!
    
    
    
    
    
    
    //MARK: Actions
    
    //To update the existing trial with response
    func updateResponse()
    {
        let realm = try! Realm()
        try! realm.write {
            self.subject.response = self.selectedButton!
        }
    }
    

    //when response button pressed:
    @IBAction func response(sender:UIButton) {
        switch sender{
        case monkey1:
            selectedButton = "A"
            monkey2.enabled = false
            advanceWithout.enabled = false
            bananas = leftBanana
        case monkey2:
            selectedButton = "B"
            monkey1.enabled = false
            advanceWithout.enabled = false
            bananas = rightBanana
        case advanceWithout:
            selectedButton = "NA"
            monkey1.enabled = false
            monkey2.enabled = false
            bananas = centerBanana
        default:
            selectedButton = "NA"
        }
        
        //cute button animation
        sender.transform = CGAffineTransformMakeScale(0.1, 0.1) //make monkey shrink
        UIView.animateWithDuration(2.0, delay: 0, //make monkey bounce back to normal size
                                       usingSpringWithDamping: 0.2,
                                       initialSpringVelocity: 6.0,
                                       options: UIViewAnimationOptions.AllowUserInteraction,
                                       animations: {
                                        sender.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        //animate and reveal banana
        if bananas != nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ResponseController.capturePosition), userInfo: nil, repeats: true) //check every .1 seconds if banana moving by calling capturePosition()
            addBananaPhysics()
        }
        
    }

    //to check if UIObject still moving (if not, trigger segue)
    func capturePosition() {
        let position = bananas.center.y
        posn.insert(position, atIndex: t)
        
        loop: if ((t % 5) == 0) {
            for n in 1 ..< 4 {
                if (posn[t] - posn[t-n] == 0 ){
                } else {
                    break loop
                }
            }
            timer.invalidate()
            self.performSegueWithIdentifier("tocontinuePlayVideo", sender: self)
        }
        t+=1
    }
    
    
    
    
  
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //don't update database with practice trials
        if (p<2) {
            p+=1
            if let destination = segue.destinationViewController as? PlayVideoController{
                destination.p = self.p
            }
        } else {
        //update database for test trials
            if segue.identifier == "tocontinuePlayVideo"  {
                i+=1
                updateResponse() //save to db
            }
        
            //pass variables to destinationVC
            if let destination = segue.destinationViewController as? PlayVideoController {
                destination.subject = self.subject
                destination.i = self.i
            }
        }
    }
    
    
    
    
    
    
    //MARK: Physics 
    
    func addBananaPhysics() {
    
        gravity = UIGravityBehavior(items: [bananas])
    
        collision = UICollisionBehavior(items: [bananas])
        collision.translatesReferenceBoundsIntoBoundary = true //containing view acts as boundary
        collision.addBoundaryWithIdentifier("barrier1", forPath: UIBezierPath(ovalInRect: monkey1.frame))
        collision.addBoundaryWithIdentifier("barrier2", forPath: UIBezierPath(ovalInRect: monkey2.frame))
        
        elasticity = UIDynamicItemBehavior(items: [bananas])
        elasticity.elasticity = 0.7 //control bounciness! (<1 -> loses velocity each bounce)
    
        //add to animator
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(elasticity)
        
    }
    
   
    
    

    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        
        // Add our bananas to the view
        view.addSubview(leftBanana)
        view.addSubview(rightBanana)
        view.addSubview(centerBanana)
        
        //animator for everything
        animator = UIDynamicAnimator(referenceView: view)
        
    }
    
    
}


/*resources for cool banana dynamics
 http://matthewpalmer.net/blog/2015/05/11/wwdc-student-scholarship-uikit-dynamics-swift-animated-device-rotation/
 https://www.raywenderlich.com/76147/uikit-dynamics-tutorial-swift
 https://omarfouad.com/blog/2014/08/02/getting-started-uikitdynamics-swift/
 */