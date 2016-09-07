//
//  startseiteViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 03.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import UIKit
import CoreData

class startseiteTableViewController: UITableViewController {
    
    var nameItems = [NSManagedObject]() // CoreData für Schlössernamen
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameItems.count //return Anzahl Schlössernamen 
        }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell")! as UITableViewCell // PrototypeCell für Schlössernamen
        let item = nameItems[indexPath.row] // Zeile für Schlössernamen
        cell.textLabel?.text = item.valueForKey("nameItem") as? String // CoreData als String
        return cell // return Schlössernamen
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "NameListEntity") // CoreData Entity
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            nameItems = results as! [NSManagedObject] // Schlössernamen als CoreData
        }
        catch {
            print("Error in viewWillAppear")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(startseiteTableViewController.addItem)) // Button hinzufügen
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.tableView.reloadData() // Daten neu laden

    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // CoreData Delegate
            let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
     //       nameItems.deleteObjects(nameItems[indexPath.row] as NSManagedObject)
           
     //       let context:NSManagedObjectContext = appDelegate.managedObjectContext
            managedContext.deleteObject(nameItems[indexPath.row] as NSManagedObject)
            
            self.tableView.endUpdates()
     //       self.tableView.reloadData()
        }
        else if editingStyle == .Insert {
            
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
    }    
    
    func addItem(sender: AnyObject) {
        performSegueWithIdentifier("segueToHinzufügenTableViewController", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}