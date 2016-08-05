//
//  WelcomeController.swift
//  events.child.2
//
//  Created by Casey Colby on 4/20/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import UIKit
import RealmSwift

class WelcomeController: UIViewController, UIAlertViewDelegate {

     @IBOutlet weak var enterSubjectInfo: UIBarButtonItem!
    
    //MARK: Variables
    
    //subject info vars
    var trial: Trial = Trial() //create new instance of Trial object
    
    //alert vars
    var saveAction: UIAlertAction!
    var cancelAction: UIAlertAction!
    
    //animation vars
    @IBOutlet weak var orangeMonkey: UIImageView!
    @IBOutlet weak var purpleMonkey: UIImageView!
    var monkeys : [UIDynamicItem]!

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var elasticity: UIDynamicItemBehavior!
    
    
    
    
    
    //MARK: Actions
    
    //Check that all fields are populated
    func validateFields() -> Bool {
        if trial.subjectNumber.isEmpty || trial.condition.isEmpty {
            let alertController = UIAlertController(title: "Validation Error", message: "All fields must be filled", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Destructive) { alert in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(alertAction)
            presentViewController(alertController, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }

    //Show subject info alert when '+' button pressed
    @IBAction func showAlert(sender:AnyObject) {
        
        //initialize controller
        let alertController = UIAlertController(title: "New Subject", message: "Enter New Subject Info", preferredStyle: .Alert)
        
        //add text fields
        let aquablue = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
        
        alertController.addTextFieldWithConfigurationHandler{ (textField:UITextField!) in
            textField.placeholder = "Subject Number"
            textField.textColor = aquablue //input text
        }
        alertController.addTextFieldWithConfigurationHandler { (textField:UITextField!) in
            textField.placeholder = "Condition"
            textField.textColor = aquablue //input text
        }
        
        //initialize actions
        cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
        })
        //handler means the block is executed when user selects that action
        // parameters -> return type (void)
        //in indicates the start of the closure body
        saveAction = UIAlertAction(title: "Save", style: .Default, handler: {action in
            self.trial.subjectNumber = "\((alertController.textFields![0] as UITextField).text!)" //unwrap array UITextFields (array of type AnyObject), cast to UITextField, and get the text variable from the entry
            self.trial.condition = "\((alertController.textFields![1] as UITextField).text!)"
            
            if self.validateFields() { //require that all fields are filled before segue is called
                self.performSegueWithIdentifier("toMeetMonkeys", sender: self) //manually segue when save button pressed
            }
        })
        
        //add actions
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        //present alert controller
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: Animation 
    
    func bounceMonkeys() {
        monkeys = [orangeMonkey, purpleMonkey]
        
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: monkeys)
        collision = UICollisionBehavior(items: monkeys)
        collision.translatesReferenceBoundsIntoBoundary = true
        elasticity = UIDynamicItemBehavior(items: monkeys)
        elasticity.elasticity = 1.06
        
        // Add to animator
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(elasticity)
        
    }
    
    
    
    //MARK: Realm Configuration
    
     //To set filename of default Realm to studyname_subjectnumber, stored at default location
    func setDefaultRealmForUser() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.URLByDeletingLastPathComponent?.URLByAppendingPathComponent("eventsk1_\(trial.subjectNumber).realm")
        
        //set this as the configuration used at the default location
        Realm.Configuration.defaultConfiguration = config
        
        print(Realm.Configuration.defaultConfiguration.fileURL!) //prints database filepath to the console (simulator)
        
    }

    
    
    
    
    //MARK: View Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        bounceMonkeys()
    }
    
    
    
    
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMeetMonkeys" {
            setDefaultRealmForUser()
        }
    
        
        if let destination = segue.destinationViewController as? MeetMonkeysController {
            destination.trial = self.trial //pass subject instance to PVC
        }
        
    }

    
}



