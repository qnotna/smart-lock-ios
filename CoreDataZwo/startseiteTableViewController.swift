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
    var filteredNameItems = [String]()
    var showSearchResults = false
    var deviceIsUnknown = Bool()
    var selectedIndex = 0
    
    /*var fetchedResultsController:NSFetchedResultsController<NSFetchRequestResult>? = nil
    
    private func searchItems() -> NSFetchedResultsController<NSFetchRequestResult> { // Laden/Abfragen der Entities
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext:NSManagedObjectContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameEntity") // CoreData Entity
        
        /*
         Optional: FetchRequest für Abfrage konfigurieren (SearchBar)
 
        let searchQuery:NSPredicate = NSPredicate("nameItem like[c] %@",searchBar.text)
        fetchRequest.predicate = searchQuery;
         
        Ende optionale Suche
        */
        
        fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil) // Cache der Abfrage
        tableView.reloadData() // Tabelle neuladen
        return fetchedResultsController!
    } */

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
    //    let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
    //    let lockEntity=managedContext.object
    //    managedContext.
        selectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        print("Zeile \(indexPath.row + 1) ausgewählt")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAnsicht" {
            if let destinationController = segue.destination as? ansichtContainerViewController {
                destinationController.selectedIndex = selectedIndex

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.checkForEntries()
        
        if showSearchResults {
            return filteredNameItems.count
        } else {
            return nameItems.count //return Anzahl Einträge
        }
        
        }
    
    func checkForEntries() {
        if nameItems.count > 0 {
            func displayNoNoEntriesMessage(message: String, viewController:UITableViewController) {
                let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.height, height: tableView.bounds.size.height))
                // message == noDataLabel.text
                noDataLabel.text             = " "
                //let message = " "
                noDataLabel.textColor        = UIColor.gray
                noDataLabel.textAlignment    = .center
                tableView.backgroundView     = noDataLabel
                noDataLabel.lineBreakMode    = NSLineBreakMode.byWordWrapping
                noDataLabel.numberOfLines    = 3
                print("Es sind Geräte gespeichert")
            }
        //  return 1
        } else {
            func displayNoEntriesMessage(message: String, viewController:UITableViewController) {
                let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.height, height: tableView.bounds.size.height))
               // noDataLabel.text             = "Keine Schlösser verfügbar. Zum Verbinden oder Konfigurieren ein SmartLock in den iOS-Geräteeinstellungen paaren."
                let message = "Keine Schlösser verfügbar. Zum Verbinden oder Konfigurieren ein SmartLock in den iOS-Geräteeinstellungen paaren."
                noDataLabel.textColor        = UIColor.gray
                noDataLabel.textAlignment    = .center
                tableView.backgroundView     = noDataLabel
                noDataLabel.lineBreakMode    = NSLineBreakMode.byWordWrapping
                noDataLabel.numberOfLines    = 3
                print("Es sind keine Geräte gespeichert")
            }
      //  return 0
        }
        //   self.checkForEntries()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")! as UITableViewCell // PrototypeCell für Schlössernamen
        let item = nameItems[(indexPath as NSIndexPath).row] // Zeile für Schlössernamen
        
        
        if showSearchResults {
            cell.textLabel?.text = filteredNameItems[indexPath.row] // Gefilterete Namen als String
            print("Gefilterter Eintrag geladen")
            return cell // return Schlössernamen
        } else {
            cell.textLabel?.text = item.value(forKey: "nameItem") as? String // CoreData als String
            print("nameItems geladen")
            return cell // return Schlössernamen
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.searchItems();

        self.checkForEntries()
        self.tableView.reloadData()
        super.viewWillAppear(true)
        print("viewWillAppear")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameEntity") // CoreData Entity
        do {
            let results = try managedContext.fetch(fetchRequest)
            nameItems = results as! [NSManagedObject] // Schlössernamen als CoreData
            self.tableView.reloadData()
            
        }
        catch {
            print("Error in viewWillAppear")
        }
    }
    
    override func viewDidLoad() {
        print(nameItems)
        print("viewDidLoad")
        super.viewDidLoad()
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(startseiteTableViewController.addItem)) // Button hinzufügen
      //  self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.reloadData() // Daten neu laden
    }
    
    /*
       func addItem(_ sender: AnyObject) {
        performSegue(withIdentifier: "segueToHinzufügenTableViewController", sender: nil)
        print("addItem")
    }
     */
    
    
    
}
