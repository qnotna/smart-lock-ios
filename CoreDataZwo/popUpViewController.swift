//
//  popUpViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 01.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import CoreData
import UIKit
import Foundation

class popUpViewController : UIViewController {
    
    @IBOutlet weak var viewController: UITableView!
    @IBOutlet weak var tableView: UITableView!
   
    @IBAction func closePopUp(sender: UIBarButtonItem) {
        self.view.removeFromSuperview()
    }
    
    var searchNameItems = [NSManagedObject]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchNameItems.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.view.removeFromSuperview()
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell")! as UITableViewCell
        let item = searchNameItems[indexPath.row]
        cell.textLabel?.text = item.valueForKey("nameItem") as? String
        return cell
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell")! as UITableViewCell
        let item = searchNameItems[indexPath.row]
        cell.textLabel?.text = item.valueForKey("nameItem") as? String
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "NameListEntity")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            searchNameItems = results as! [NSManagedObject]
        }
        catch {
            print("Error in viewWillAppear")
        }
    }

    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true;
        view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}