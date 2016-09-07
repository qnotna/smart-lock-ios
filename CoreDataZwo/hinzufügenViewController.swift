//
//  hinzufügenViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 03.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class hinzufügenTableViewController : UITableViewController {
    
    @IBOutlet weak var newNameItemsTextField: UITextField!
    
    var nameItems = [NSManagedObject]()
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(hinzufügenTableViewController.doneSavingItem)) // Button hinzufügen
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(hinzufügenTableViewController.cancelSavingItem)) // Button hinzufügen
     //   self.addItem()
        super.viewDidLoad()
    }
    
    func doneSavingItem(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let entity = NSEntityDescription.entityForName("NameListEntity", inManagedObjectContext: managedContext) // CoreData Entity
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) // Speichern als CoreData Entity
        item.setValue(newNameItemsTextField.text!, forKey: "nameItem") // CoreData Attribute
        do {
            try managedContext.save()
        } catch {
            print ("Error")
        }
        performSegueWithIdentifier("segueDoneToStartseiteTableViewController", sender: nil)
    }
    
    func cancelSavingItem(sender: AnyObject) {
        performSegueWithIdentifier("segueCancelToStartseiteTableViewController", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
