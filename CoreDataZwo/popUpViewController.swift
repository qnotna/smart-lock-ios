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
   
    @IBAction func closePopUp(_ sender: UIBarButtonItem) {
        self.view.removeFromSuperview()
    }
    
    var searchNameItems = [NSManagedObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchNameItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        self.view.removeFromSuperview()
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")! as UITableViewCell
        let item = searchNameItems[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = item.value(forKey: "nameItem") as? String
        return cell
    }
        
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")! as UITableViewCell
        let item = searchNameItems[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = item.value(forKey: "nameItem") as? String
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameListEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            searchNameItems = results as! [NSManagedObject]
        }
        catch {
            print("Error in viewWillAppear")
        }
    }

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true;
        view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
