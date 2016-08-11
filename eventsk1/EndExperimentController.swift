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
    
     @IBOutlet weak var orangeMonkey: UIImageView!
    @IBOutlet weak var purpleMonkey: UIImageView!

    //MARK: Variables
    
    //init dynamics properties
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var elasticity: UIDynamicItemBehavior!

    var monkeys : [UIDynamicItem]!
    
    var monkeyAnimator: UIDynamicAnimator!
    var monkeyGravity: UIGravityBehavior!
    var monkeyCollision: UICollisionBehavior!
    var monkeyElasticity: UIDynamicItemBehavior!
    
    
    
    
    
    //MARK: Background Animations
    
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
    
    
    
    
    
    //MARK: View Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        bounceMonkeys()
    }
    
}

