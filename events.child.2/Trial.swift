//
//  Trial.swift
//  events.child.2
//
//  Created by Casey Colby on 4/22/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import Foundation
import RealmSwift

class Trial: Object {

    dynamic var subjectNumber = ""
    dynamic var condition = ""
    dynamic var order = 1 //odd/default (1), even(2)
    dynamic var created = NSDate()
    dynamic var trialNumber = 0
    
    dynamic var Anumber = ""
    dynamic var Aheight = ""
    dynamic var Aduration = ""
    dynamic var Bnumber = ""
    dynamic var Bheight = ""
    dynamic var Bduration = ""
    dynamic var response = ""
    
    dynamic var numberWin = ""
    dynamic var heightWin = ""
    dynamic var durationWin = ""
    
    dynamic var numberResp = 0
    dynamic var heightResp = 0
    dynamic var durationResp = 0
}