//
//  setPasswordTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 04.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class setPasswordTableViewController : UIViewController {
    
    func saveItem() {
        performSegue(withIdentifier: "segueToHinzufügenViewController", sender: nil)
    }
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(setPasswordTableViewController.saveItem)) // Button hinzufügen
        self.saveItem()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
