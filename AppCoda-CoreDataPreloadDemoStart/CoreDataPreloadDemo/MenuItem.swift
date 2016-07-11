//
//  MenuItem.swift
//  CoreDataPreloadDemo
//
//  Created by Simon Ng on 13/5/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation
import CoreData

class MenuItem: NSManagedObject {
    @NSManaged var name:String?
    @NSManaged var detail:String?
    @NSManaged var price:NSNumber?
    
}