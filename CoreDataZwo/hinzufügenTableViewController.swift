//
//  hinzufügenTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 03.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import LocalAuthentication

class hinzufügenTableViewController : UITableViewController {
    
    var rot: Float = 0
    var grün: Float = 0
    var blau: Float = 0
    
    var rotColorItems = [NSManagedObject]()
    var grünColorItems = [NSManagedObject]()
    var blauColorItems = [NSManagedObject]()
    
    @IBOutlet weak var statusCell: UITableViewCell!
    @IBOutlet weak var colorView: UILabel!
    @IBAction func dismissModalViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var passwordSwitch: UISwitch!
    
    @IBAction func togglePasswordSwitch(_ sender: UISwitch) {
        if passwordSwitch.isOn {
            performSegue(withIdentifier: "segueFromHinzufügenToPassword", sender: self)
        } else {
            print("Passwort deaktiviert")
        }
    }
       /*
    func loadRed() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ColorEntity") // CoreData Entity
        do {
            let results = try managedContext.fetch(fetchRequest)
            rotColorItems = results as! [NSManagedObject] // Farben als CoreData
            for rotColorItems in results {
                rot == (rotColorItems as AnyObject).value(forKey: "redItem")
                print("Rot geladen")
            }
        }
        catch {
            print("error")
        }
    }
    
    func loadGreen() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ColorEntity") // CoreData Entity
        do {
            let results = try managedContext.fetch(fetchRequest)
            grünColorItems = results as! [NSManagedObject] // Farben als CoreData
            for grünColorItems in results {
                grün == (grünColorItems as AnyObject).value(forKey: "greenItem")
                print("Grün geladen")
            }
        }
        catch {
            print("error")
        }
    }

    func loadBlue() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ColorEntity") // CoreData Entity
        do {
            let results = try managedContext.fetch(fetchRequest)
            blauColorItems = results as! [NSManagedObject] // Farben als CoreData
            for blauColorItems in results {
                blau == (blauColorItems as! Float).value(forKey: "blueItem")
                print("Blau geladen")
            }
        }
        catch {
            print("error")
        }
    }

    func loadColor() {
        self.loadRed()
        self.loadGreen()
        self.loadBlue()
        colorView.backgroundColor = UIColor(red: CGFloat(rot), green: CGFloat(grün), blue: CGFloat(blau), alpha: 1.0)
    }
    */
    @IBOutlet weak var passwordTypeLabel: UILabel!
    @IBOutlet weak var newNameItemsTextField: UITextField!
    @IBOutlet weak var touchIDSwitch: UISwitch!
    var touchID = Bool()
    
    var passwordTypeItems = [NSManagedObject]()
    
   /* func uiBusy() {
        let navigationItem: UINavigationItem
        let uiBusy = UIActivityIndicatorView(activityIndicatorStyle: .white)
        uiBusy.hidesWhenStopped = true
        uiBusy.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtomItem(customView: uiBusy)
    }
    */
    func loadPasswordTypeItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PasswordEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            passwordTypeItems = results as! [NSManagedObject]
            for passwordTypeItems in results {
                passwordTypeLabel.text = (passwordTypeItems as AnyObject).value(forKey: "passwordTypeItem") as? String
                print("PasswordTypeItems geladen")
            }
        }
        catch {
            print("error")
        }
    }
    
    @IBAction func toggleTouchIDSwitch(_ sender: Any) {
        if touchIDSwitch.isOn {
            loadTouchID()
            touchID = true
            print("TouchID aktiviert")
        } else {
            touchID = false
            print("TouchID deaktiviert")
        }
    }
    
    func loadTouchID() {
        let authentificationContext = LAContext()
        if authentificationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
        } else {
            showAlertViewForNoBiometrics()
            return
        }
    }
    
    func showAlertViewForConnectionLoss() {
        let alertController = UIAlertController(title: nil, message: "Die Verbindung zum SmartLock wurde unterbrochen. Überprüfen Sie den Batteriestatus und die Entfernung zum SmartLock.", preferredStyle: .actionSheet)
        let destroyAction = UIAlertAction(title: "Schließen", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
            print("Hinzufügen abgebrochen")
        }
        alertController.addAction(destroyAction)
        self.present(alertController, animated: true) {
        }
    }

    
    func showAlertViewForNoBiometrics() {
        let alertController = UIAlertController(title: nil, message: "Touch-ID wird auf diesem Gerät nicht unterstützt", preferredStyle: .actionSheet)
        let destroyAction = UIAlertAction(title: "Touch-ID deaktivieren", style: .destructive) { (action) in
            self.touchIDSwitch.setOn(false, animated: true)
            print("TouchID-Aktivierung unterdrückt")
        }
        alertController.addAction(destroyAction)
        self.present(alertController, animated: true) {
        }
    }
    
    var touchIDState = [NSManagedObject]()

    func saveTouchIDState() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "PasswordEntity", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        item.setValue(touchID, forKey: "touchIDStateItem")
        do {
            try managedContext.save()
            print("saved TouchIDItems as \(touchID)")
        } catch {
            print ("Error")
        }
    }
    
    @IBOutlet weak var sharingSwitch: UISwitch!
    
    @IBAction func toggleSharingSwitch(_ sender: Any) {
        if sharingSwitch.isOn {
            print("Freigabe aktiviert")
        } else {
            print("Freigabe deaktiviert")
        }
    }
    
    
    var nameItems = [NSManagedObject]()
    var identifierItems = [NSManagedObject]()
    
    override func viewWillAppear(_ animated: Bool) {
  //      self.loadColor()
        self.loadPasswordTypeItems()
        self.createID(length: 10)
        super.viewWillAppear(true)
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = 12.5
    }
    
    @IBAction func saveSmartLock(_ sender: UIButton) {
        self.saveTouchIDState()
        self.saveName()
        self.saveIdentifier()
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveName() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let entity = NSEntityDescription.entity(forEntityName: "NameEntity", in: managedContext) // CoreData Entity
        let item = NSManagedObject(entity: entity!, insertInto: managedContext) // Speichern als CoreData Entity
        item.setValue(newNameItemsTextField.text!, forKey: "nameItem") // CoreData Attribute
        do {
            try managedContext.save()
            print("saved nameItems as \(nameItems as AnyObject)")
        } catch {
            print ("Error")
        }
    }
    
    func saveIdentifier() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "PasswordEntity", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        item.setValue(IDLabel.text!, forKey: "identifierItem")
        do {
            try managedContext.save()
            print("saved IDItems as \(identifierItems as AnyObject)")
        } catch {
            print ("Error")
        }
    }
                        // Create ID
    
    @IBOutlet weak var IDLabel: UILabel!
    
    func createID(length: Int) -> String {
            
        let erlaubteZeichen = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(erlaubteZeichen.characters.count)
        var zufallsID = ""
            
        for _ in 0..<length {
            let zufallszahl = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = erlaubteZeichen.index(erlaubteZeichen.startIndex, offsetBy: zufallszahl)
            let neuesZeichen = erlaubteZeichen[randomIndex]
                zufallsID += String(neuesZeichen)
        }
        print("Neue ID: \(zufallsID)")
        IDLabel.text = zufallsID

        return zufallsID
    }

    /*
    override func viewDidDisappear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let entity = NSEntityDescription.entity(forEntityName: "NameListEntity", in: managedContext) // CoreData Entity
        let item = NSManagedObject(entity: entity!, insertInto: managedContext) // Speichern als CoreData Entity
        item.setValue(newNameItemsTextField.text!, forKey: "nameItem") // CoreData Attribute
        do {
            try managedContext.save()
            print("saved")
        } catch {
            print ("Error")
        }

    }*/
    /*
    func doneSavingItem (_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let entity = NSEntityDescription.entity(forEntityName: "NameListEntity", in: managedContext) // CoreData Entity
        let item = NSManagedObject(entity: entity!, insertInto: managedContext) // Speichern als CoreData Entity
        item.setValue(newNameItemsTextField.text!, forKey: "nameItem") // CoreData Attribute
        do {
            try managedContext.save()
        } catch {
            print ("Error")
        }
 //       performSegue(withIdentifier: "segueDoneToStartseiteTableViewController", sender: nil)
    }
    */
 /*   func cancelSavingItem(_ sender: AnyObject) {
        performSegue(withIdentifier: "segueCancelToStartseiteTableViewController", sender: nil)
    } */

}

