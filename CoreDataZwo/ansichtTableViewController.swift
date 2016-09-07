//
//  viewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 01.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ansichtTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var nameItems = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "NameListEntity") // CoreData Entity
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            nameItems = results as! [NSManagedObject] // Schlössernamen als CoreData
            for nameItems in results {
                nameLabel.text = nameItems.valueForKey("nameItem") as? String
            }
        }
        catch {
            print("error")
        }
            }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}