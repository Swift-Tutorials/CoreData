//
//  ListTableViewController.swift
//  CoreData_Demo
//
//  Created by Yogesh Bharate on 08/10/15.
//  Copyright © 2015 Yogesh Bharate. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
  
  // Variables
  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  var myList : Array <AnyObject> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    
    let freq = NSFetchRequest(entityName: "List")
    let context : NSManagedObjectContext = appDelegate.managedObjectContext
    do {
      myList = try context.executeFetchRequest(freq)
      tableView.reloadData()
    } catch let error as NSError {
      // Show error "Unable to fetch"
      print("Could not fetch the data \(error), \(error.userInfo)")
    }
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "update" {
      let selectedItem : NSManagedObject = myList[self.tableView.indexPathForSelectedRow!.row]
        as! NSManagedObject
      
      let IVC : ViewController  = segue.destinationViewController as! ViewController
      
      IVC.name = selectedItem.valueForKey("name") as! String
      IVC.color = selectedItem.valueForKey("color") as! String
      IVC.origin = selectedItem.valueForKey("origin") as! String
      
      IVC.existingItem = selectedItem
    }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func editing(sender: UIBarButtonItem) {
    self.editing = !self.editing
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return myList.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
    if let ip : NSIndexPath = indexPath {
      let data : NSManagedObject = myList[ip.row] as! NSManagedObject
      cell.textLabel!.text = data.valueForKey("name") as? String
      cell.detailTextLabel?.text = data.valueForKey("color") as? String
    }
    return cell
  }
  
  override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    return .None
  }
  
  override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
  }
  
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    let context : NSManagedObjectContext = appDelegate.managedObjectContext
    if editingStyle == .Delete {
      if let tv : UITableView = tableView {
        context.deleteObject(myList[indexPath.row] as! NSManagedObject)
        myList.removeAtIndex(indexPath.row)
        tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      }
      
      do {
        try context.save()
      } catch {
        abort()
      }
    }
  }
  
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    let itemToMove = myList[fromIndexPath.row]
    myList.removeAtIndex(fromIndexPath.row)
    myList.insert(itemToMove, atIndex: toIndexPath.row
    )
  }
  
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
