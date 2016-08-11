//
//  Stimuli.swift
//  events.child.2
//
//  Created by Casey Colby on 7/27/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import Foundation

class Stimuli {
    
    let practice: [NSObject] = [
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
   
    let order2: [NSObject] = [
        NSBundle.mainBundle().pathForResource("2_600_8_4_400_6", ofType: "mov")!, //7
        NSBundle.mainBundle().pathForResource("3_800_4_4_400_6", ofType: "mov")!, //1
        NSBundle.mainBundle().pathForResource("4_400_6_3_800_4", ofType: "mov")!, //2
        NSBundle.mainBundle().pathForResource("2_800_6_3_400_8", ofType: "mov")!, //3
        NSBundle.mainBundle().pathForResource("4_600_4_2_800_6", ofType: "mov")!, //6
        NSBundle.mainBundle().pathForResource("2_800_6_4_600_4", ofType: "mov")!, //5
        NSBundle.mainBundle().pathForResource("4_400_6_2_600_8", ofType: "mov")!, //8
        NSBundle.mainBundle().pathForResource("3_400_8_2_800_6", ofType: "mov")!, //4
    ]

}

