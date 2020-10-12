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

class setPasswordTableViewController : UITableViewController {
        
    var passwordItems = [NSManagedObject]()
    
    @IBOutlet weak var setPasswordTextField: UITextField!
    
    @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneDismissingModalViewController(_ sender: UIBarButtonItem) {
        
        func saveCoreDataAttributes() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
            let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
            let entity = NSEntityDescription.entity(forEntityName: "PasswordEntity", in: managedContext) // CoreData Entity
            let item = NSManagedObject(entity: entity!, insertInto: managedContext) // Speichern als CoreData Entity
            item.setValue(setPasswordTextField.text!, forKey: "passwordItem") // CoreData Attribute
            do {
                try managedContext.save()
                print("saved passwordItems as \(passwordItems as AnyObject)")
            } catch {
                print ("Error")
            }
        }

        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        setPasswordTextField.becomeFirstResponder()
    }
    
    
    
    /*
    func saveItem() {
        performSegue(withIdentifier: "segueToHinzufügenViewController", sender: nil)
    }
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(setPasswordTableViewController.saveItem)) // Button hinzufügen
        self.saveItem()
        super.viewDidLoad()
    } */
}
