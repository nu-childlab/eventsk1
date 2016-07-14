//
//  Subject.swift
//  events.child.2
//
//  Created by Casey Colby on 4/22/16.
//  Copyright © 2016 Casey Colby. All rights reserved.
//

import Foundation
import RealmSwift

class Subject: Object {

    dynamic var subjectNumber = ""
    dynamic var condition = ""
    dynamic var order = 0 //odd s# corresponds to order 0 
    dynamic var created = NSDate()
    dynamic var trialNumber = 0
    dynamic var Anumber = ""
    dynamic var Aheight = ""
    dynamic var Aduration = ""
    dynamic var Bnumber = ""
    dynamic var Bheight = ""
    dynamic var Bduration = ""
    dynamic var response = ""
}