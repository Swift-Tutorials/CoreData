//
//  ViewController.swift
//  CD-Grocery-Image
//
//  Created by Yogesh Bharate on 05/03/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import UIKit
import CoreData

class AddEditVC : UIViewController, NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  // Variables
  var item : Entity? = nil
  var moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
  
  
  // IBOutlets
  @IBOutlet weak var itemName: UITextField!
  @IBOutlet weak var itemNote: UITextField!
  @IBOutlet weak var itemQty: UITextField!
  @IBOutlet weak var imageHolder: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    if item != nil {
      itemName.text = item?.name
      itemNote.text = item?.note
      itemQty.text  = item?.qty
      imageHolder.image = UIImage(data: (item?.image)!)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func saveTapped(sender: AnyObject) {
    if item != nil {
      editItem()
    } else {
      createNewItem()
    }
    dismissVC()
  }

  @IBAction func cancelTapped(sender: AnyObject) {
    dismissVC()
  }
  
  func dismissVC() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  @IBAction func addImageFromDevice(sender: AnyObject) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = .PhotoLibrary
    pickerController.allowsEditing = true
    
    self.presentViewController(pickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    self.dismissViewControllerAnimated(true, completion: nil)
    self.imageHolder.image = image
  }
  
  @IBAction func addImageFromCamera(sender: AnyObject) {
    let pickerImage = UIImagePickerController()
    pickerImage.delegate = self
    pickerImage.sourceType = .Camera
    pickerImage.allowsEditing = true
    
    self.presentViewController(pickerImage, animated: true, completion: nil)
  }
  
  func createNewItem() {
    let entityDesc = NSEntityDescription.entityForName("Entity", inManagedObjectContext: moc)
    let item = Entity(entity:entityDesc!, insertIntoManagedObjectContext: moc)
    item.name = itemName.text
    item.note = itemNote.text
    item.qty = itemQty.text
    item.image = UIImagePNGRepresentation(imageHolder.image!)
    
    do {
      try moc.save()
    } catch {
      return
    }
  }
  
  func editItem() {
    item?.name = itemName.text
    item?.note = itemNote.text
    item?.qty = itemQty.text
    item?.image = UIImagePNGRepresentation(imageHolder.image!)
    
    do {
      try moc.save()
    } catch {
      return
    }
  }
  
}

