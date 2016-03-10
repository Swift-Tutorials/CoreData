//
//  Entity+CoreDataProperties.swift
//  CD-Grocery-Image
//
//  Created by Yogesh Bharate on 06/03/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entity {

    @NSManaged var image: NSData?
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var qty: String?

}
