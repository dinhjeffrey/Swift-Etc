//
//  Tweet+CoreDataProperties.swift
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

extension Tweet {

    @NSManaged var created: String?
    @NSManaged var id: String?
    @NSManaged var text: NSDate?
    @NSManaged var tweeter: TwitterUser?

}
