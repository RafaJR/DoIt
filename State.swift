//
//  State.swift
//  TaskManager
//
//  Created by Rafa on 14/8/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import Foundation
import CoreData

class State: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var state_description: String
    
    
}


