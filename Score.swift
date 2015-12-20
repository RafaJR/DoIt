//
//  Score.swift
//  TaskManager
//
//  Created by Rafa on 14/8/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import Foundation
import CoreData

class Score: NSManagedObject {

    @NSManaged var score: NSDecimalNumber
    @NSManaged var score_day: NSDate

}
