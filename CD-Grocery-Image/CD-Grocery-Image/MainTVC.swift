//
//  MainTVC.swift
//  CD-Grocery-Image
//
//  Created by Yogesh Bharate on 06/03/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import UIKit
import CoreData

class MainTVC: UITableViewController, NSFetchedResultsControllerDelegate {
  
  
  // Variables
  let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
  var frc = NSFetchedResultsController()
  
  
  func fetchRequest() -> NSFetchRequest {
    let fetchRequest = NSFetchRequest(entityName: "Entity")
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    return fetchRequest
  }
  
  func getFRC() -> NSFetchedResultsController {
    frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
    
    return frc
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    frc = getFRC()
    frc.delegate = self
    
    do {
      try frc.performFetch()
    } catch {
      print("Failed to fetch")
    }
    
    self.tableView.rowHeight = 60
    self.tableView.backgroundView = UIImageView(image: UIImage(named: "orange-bg"))
    self.tableView.reloadData()
  }
  
  override func viewDidAppear(animated: Bool) {
//    frc = getFRC()
//    frc.delegate = self
//    
//    do {
//      try frc.performFetch()
//    } catch {
//      print("Failed to fetch")
//    }
//    self.tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    let numberOfSection = frc.sections?.count
    return numberOfSection!
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let numberOfRowInSection = frc.sections?[section].numberOfObjects
    return numberOfRowInSection!
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
    if indexPath.row % 2 == 0 {
      cell.backgroundColor = UIColor.clearColor()
    } else {
      cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
      cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
      cell.detailTextLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
    }
    
    // Configure cell
    cell.textLabel?.textColor = UIColor.darkGrayColor()
    cell.detailTextLabel?.textColor = UIColor.darkGrayColor()
    
    let item = frc.objectAtIndexPath(indexPath) as! Entity
    cell.textLabel?.text = item.name
    
    let note = item.note
    let qty = item.qty
    let noteNQty = "Note: " + note! + " Qty:" + qty!
    cell.detailTextLabel?.text = noteNQty
    cell.imageView?.image = UIImage(data: item.image!)
    
    return cell
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
    moc.deleteObject(managedObject)
    
    do {
      try moc.save()
    } catch {
      print("Failed to save.")
      return
    }
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    tableView.reloadData()
  }

  
  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the specified item to be editable.
  return true
  }
  */
  
  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  }
  */
  
  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
  
  }
  */
  
  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the item to be re-orderable.
  return true
  }
  */
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if segue.identifier == "edit" {
      
      let cell = sender as! UITableViewCell
      let indexPath = tableView.indexPathForCell(cell)
      let itemController : AddEditVC = segue.destinationViewController as! AddEditVC
      let item : Entity = frc.objectAtIndexPath(indexPath!) as! Entity
      itemController.item = item
      
    }
    
  }

  
}
