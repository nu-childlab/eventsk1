//
//  EndExperimentController.swift
//  events.child.2
//
//  Created by Casey Colby on 5/7/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import Foundation
import UIKit

class EndExperimentController : UIViewController {
    
    //MARK: Variables
//    var newBanana: UILabel!
//    var bananas = [UIView]()
//    var newEmoji: UILabel!
//    let emojis = ["😀","👏","⭐️","💯","🏆","🎖","🎉","🎈"]
    
    // MARK: Init Dynamics properties
    
    // Animator for components
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var elasticity: UIDynamicItemBehavior!

    //MARK: Actions

//    func addBanana() -> UIView {
//        newBanana = UILabel(frame: CGRect(x: 0, y:0, width: 100.0, height: 100.0))
//        newBanana.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
//        newBanana.text = "🍌"
//        newBanana.font = newBanana.font.fontWithSize(94)
//        view.addSubview(newBanana)
//        bananas.append(newBanana)
//        
//        return newBanana
//    }
    
//    func addEmoji() -> UIView {
//        newEmoji = UILabel(frame: CGRect(x:0,y:0,width: 100.0, height:100.0))
//        newEmoji.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/2)
//        newEmoji.text = ""
//        newEmoji.font = newEmoji.font.fontWithSize(80)
//        view.addSubview(newEmoji)
//        bananas.append(newEmoji)
//        
//        return newEmoji
//    }
    
//    func bananaPhysics () {
//        
//        animator = UIDynamicAnimator(referenceView: view)
//        
//        gravity = UIGravityBehavior(items: bananas)
//        collision = UICollisionBehavior(items: bananas)
//        collision.translatesReferenceBoundsIntoBoundary = true
//        elasticity = UIDynamicItemBehavior(items: bananas)
//        elasticity.elasticity = 1.08
//        
//        // Add to animator
//        animator.addBehavior(gravity)
//        animator.addBehavior(collision)
//        animator.addBehavior(elasticity)
//        
//    }

    //MARK: View Lifecycle
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(true)
//        for i in 0...7 {
//           // addBanana()
//            addEmoji()
//            newEmoji.text = emojis[i]
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        bounceMonkeys()
//        bananaPhysics()
    }
    
    //MARK: Monkeys bouncing in background
    
    @IBOutlet weak var orangeMonkey: UIImageView!
    @IBOutlet weak var purpleMonkey: UIImageView!
    
    var monkeys : [UIDynamicItem]!
    
    var monkeyAnimator: UIDynamicAnimator!
    var monkeyGravity: UIGravityBehavior!
    var monkeyCollision: UICollisionBehavior!
    var monkeyElasticity: UIDynamicItemBehavior!
    
    func bounceMonkeys() {
        monkeys = [orangeMonkey, purpleMonkey]
        
        monkeyAnimator = UIDynamicAnimator(referenceView: view)
        
        monkeyGravity = UIGravityBehavior(items: monkeys)
        monkeyCollision = UICollisionBehavior(items: monkeys)
        monkeyCollision.translatesReferenceBoundsIntoBoundary = true
        monkeyElasticity = UIDynamicItemBehavior(items: monkeys)
        monkeyElasticity.elasticity = 1.08
        
        // Add to animator
        monkeyAnimator.addBehavior(monkeyGravity)
        monkeyAnimator.addBehavior(monkeyCollision)
        monkeyAnimator.addBehavior(monkeyElasticity)
        
    }
    
}

