//
//  Property.swift
//  TaskManager
//
//  Created by Rafa on 14/8/15.
//  Copyright (c) 2015 rafael.jimenez.reina. All rights reserved.
//

import Foundation
import CoreData

class Property: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var property_description: String
    @NSManaged var bonus: NSNumber
    
}
