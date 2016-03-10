//
//  Model.swift
//  CoreData_Demo
//
//  Created by Yogesh Bharate on 08/10/15.
//  Copyright © 2015 Yogesh Bharate. All rights reserved.
//

import UIKit
import CoreData

@objc(Model)
class Model: NSManagedObject {
  @NSManaged var name : String
  @NSManaged var origin : String
  @NSManaged var color : String
}
