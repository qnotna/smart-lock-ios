//
//  detailSuchenTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 06/10/2016.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class detailSuchenTableViewController : UITableViewController {
    
  //  var coordinateItems = [NSManagedObject]()
    var latitudeItems = [NSManagedObject]()
    var longitudeItems = [NSManagedObject]()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        loadLatitudeItems()
        loadLongitudeItems()
        // print("coordinateItems als latitudeItem: \((latitudeItems as AnyObject).value(forKey: "latitudeItem")), longitudeItem: \((longitudeItems as AnyObject).value(forKey: "longitudeItem")) geladen")
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    func loadLatitudeItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoordninatesEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            latitudeItems = results as! [NSManagedObject]
            for latitudeItems in results {
                latitudeLabel.text = ((latitudeItems) as AnyObject!).value(forKey: "latitudeItem") as? String
                print("Breitengrad: \(latitudeItems)")
            }
        }
        catch {
            print("error in loadLatitudeItems")
        }
    }

    func loadLongitudeItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoordninatesEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            longitudeItems = results as! [NSManagedObject]
            for longitudeItems in results {
                longitudeLabel.text = ((longitudeItems) as AnyObject!).value(forKey: "longitudeItem") as? String
                print("Längengrad: \(longitudeItems)")
            }
        }
        catch {
            print("error in loadLatitudeItems")
        }
    }

    
    @IBAction func dismissModalViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
