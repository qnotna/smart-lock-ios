//
//  suchenTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 27/09/2016.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class suchenTableViewController : UITableViewController {
    
    let showSearchResults = false
    
    @IBAction func fertigButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)

    }
    
    var searchNameItems = [NSManagedObject]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")! as UITableViewCell // PrototypeCell für Schlössernamen
        let item = searchNameItems[(indexPath as NSIndexPath).row] // Zeile für Schlössernamen
        cell.textLabel?.text = item.value(forKey: "nameItem") as? String // CoreData als String
        return cell // return Schlössernamen
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if showSearchResults {
            return searchNameItems.count
        } else {
            return searchNameItems.count //return Anzahl Einträge
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameEntity") // CoreData Entity
        do {
            let results = try managedContext.fetch(fetchRequest)
            searchNameItems = results as! [NSManagedObject] // Schlössernamen als CoreData
            self.tableView.reloadData()
            
        }
        catch {
            print("Error in viewWillAppear")
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetailSuchenContainerViewController", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
}
