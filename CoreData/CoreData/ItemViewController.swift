//
//  ViewController.swift
//  CoreData
//
//  Created by Yogesh Bharate on 08/10/15.
//  Copyright © 2015 Yogesh Bharate. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  // IBOutlets
  @IBOutlet var txtFdName: UITextField!
  @IBOutlet var txtFdOrigin: UITextField!
  @IBOutlet var txtFdColor: UITextField!
  
  // Varibles
  var name : String = ""
  var origin : String = ""
  var color : String = ""
  var existingItem : NSManagedObject!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if (existingItem != nil) {
      txtFdName.text = name
      txtFdColor.text = color
      txtFdOrigin.text = origin
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func Cancel(sender: AnyObject) {
    self.navigationController?.popToRootViewControllerAnimated(true
    )
  }
  
  // Save the data into the CoreData
  @IBAction func saveTapped(sender: AnyObject) {
    // Initialized the appDelegates
    let appDelegate  = UIApplication.sharedApplication().delegate as? AppDelegate
    
    // Reference Managed Object Context
    let context : NSManagedObjectContext = appDelegate!.managedObjectContext
    let en = NSEntityDescription.entityForName("List", inManagedObjectContext: context)

    // Check for exiting Item
    if (existingItem != nil) {
      existingItem.setValue(txtFdName.text, forKey: "name")
      existingItem.setValue(txtFdColor.text, forKey: "color")
      existingItem.setValue(txtFdOrigin.text, forKey: "origin")
    } else {
      // Create instance of our data model and initialized
      let newItem = Model(entity:en!, insertIntoManagedObjectContext:context)
      
      // Map our Property
      newItem.name = txtFdName.text!
      newItem.color = txtFdColor.text!
      newItem.origin = txtFdOrigin.text!
      print(newItem, true)
    }
    
    // Save our context
    do {
        try context.save()
    } catch let error as NSError {
      // Show Alert View "Unable to save"
      print("Could not save \(error), \(error.userInfo)")
    }
    self.navigationController?.popToRootViewControllerAnimated(true)
  }

}

