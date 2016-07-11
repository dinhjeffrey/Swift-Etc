//
//  TwitterUser+CoreDataProperties.swift
//  Core Data Example
//
//  Created by jeffrey dinh on 7/11/16.
//  Copyright © 2016 jeffrey dinh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TwitterUser {

    @NSManaged var screenName: String?
    @NSManaged var name: String?
    @NSManaged var tweets: NSSet?

}
