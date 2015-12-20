//
//  Task.swift
//  TaskManager
//
//  Created by Rafa on 14/8/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var detail: String
    @NSManaged var finish_stimated_date: NSDate
    @NSManaged var init_stimated_date: NSDate
    @NSManaged var short_description: String
    @NSManaged var state: State
    @NSManaged var properties: NSSet
    
    //TODO
    internal func getStimatedScore()->Int {
        
        return 10;
        
    }
    
}
