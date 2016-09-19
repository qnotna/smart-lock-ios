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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameItems.count //return Anzahl Schlössernamen 
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")! as UITableViewCell // PrototypeCell für Schlössernamen
        let item = nameItems[(indexPath as NSIndexPath).row] // Zeile für Schlössernamen
        cell.textLabel?.text = item.value(forKey: "nameItem") as? String // CoreData als String
        return cell // return Schlössernamen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameListEntity") // CoreData Entity
        do {
            let results = try managedContext.fetch(fetchRequest)
            nameItems = results as! [NSManagedObject] // Schlössernamen als CoreData
        }
        catch {
            print("Error in viewWillAppear")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(startseiteTableViewController.addItem)) // Button hinzufügen
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.reloadData() // Daten neu laden

    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
            let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
     //       nameItems.deleteObjects(nameItems[indexPath.row] as NSManagedObject)
           
     //       let context:NSManagedObjectContext = appDelegate.managedObjectContext
            managedContext.delete(nameItems[(indexPath as NSIndexPath).row] as NSManagedObject)
            
            self.tableView.endUpdates()
     //       self.tableView.reloadData()
        }
        else if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }    
    
    func addItem(_ sender: AnyObject) {
        performSegue(withIdentifier: "segueToHinzufügenTableViewController", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
