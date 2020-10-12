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
import LocalAuthentication
import UserNotifications
import CoreLocation
import AudioToolbox

@available(iOS 10.0, *)
class ansichtTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var colorView: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var unlockSmartLockButton: UIButton!
    
    var nameItems = [NSManagedObject]()
    var identifierItems = [NSManagedObject]()
    
    var selectedIndex = 0
    
    var redItems = [NSManagedObject]()
    var red = 1.0
    var greenItems = [NSManagedObject]()
    var green = 1.0
    var blueItems = [NSManagedObject]()
    var blue = 1.0
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadRedItems()
        self.loadGreenItems()
        self.loadBlueItems()
        self.loadNameItems()
        self.loadBlueItems()
        self.loadIdentifierItems()
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = 12.5
        super.viewWillAppear(true)
    }
    
    func loadRedItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ColorEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            redItems = results as! [NSManagedObject]
            for redItems in results {
                let rot = (redItems as AnyObject).value(forKey: "redItem") as? String
                print("Rot-Wert \(rot ?? "Fehler")")
                self.setColor()
            }
        }
        catch {
            print("error")
        }
    }
    func loadGreenItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ColorEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            greenItems = results as! [NSManagedObject]
            for greenItems in results {
                let green = (greenItems as AnyObject).value(forKey: "greenItem") as? String
                print("Grün-Wert \(green ?? "Fehler")")
                self.setColor()
            }
        }
        catch {
            print("error")
        }
    }
    func loadBlueItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ColorEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            blueItems = results as! [NSManagedObject]
            for blueItems in results {
                let blue = (blueItems as AnyObject).value(forKey: "blueItem") as? String
                print("Blau-Wert \(blue ?? "Fehler")")
                self.setColor()
            }
        }
        catch {
            print("error")
        }
    }
    
    func setColor() {
      //  let redFloat = (redItems as NSNumber).floatValue
        //let greenFloat = (greenItems as NSNumber).floatValue
        //let blueFloat = (blueItems as NSNumber).floatValue
        colorView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)

    }
    
    func loadTouchID() {
        let authentificationContext = LAContext()
        if authentificationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
        } else {
            print("kein touch id sensor/finger gespeichert")
            return
        }
    }
    
    @IBAction func unlockSmartLock(_ sender: UIButton) {
        
 //       locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse // ||
          /*  CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized) */ {
            
            let latitude = locationManager.location?.coordinate.latitude
            let longitude = locationManager.location?.coordinate.longitude
            
            print("Aufgenommene Koordinaten: Breitengrad: \(latitude!), Längengrad: \(longitude!)")
            
            func saveLatitudeItems() {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let entity = NSEntityDescription.entity(forEntityName: "CoordinatesEntity", in: managedContext)
                let item = NSManagedObject(entity: entity!, insertInto: managedContext)
                item.setValue(latitude!, forKey: "latitudeItem")
                do {
                    try managedContext.save()
                    print("saved latitudeItem as \(latitude!)")
                } catch {
                    print ("Error in unlockSmartLock (saveLatitudeItems)")
                }
            }
            func saveLongitudeItems() {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let entity = NSEntityDescription.entity(forEntityName: "CoordinatesEntity", in: managedContext)
                let item = NSManagedObject(entity: entity!, insertInto: managedContext)
                item.setValue(latitude!, forKey: "longitudeItem")
                do {
                    try managedContext.save()
                    print("saved longitudeItem as \(longitude!)")
                } catch {
                    print ("Error in unlockSmartLock (saveLongitudeItems)")
                }
            }
            
        } else {
            print("Location not authorized")
        }

        getNotificationPermission()
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Benachrichtigung erfolgreich geplant")
            } else {
                print("Error in scheduleNotification")
            }
        })
        print("Entriegelt")
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        unlockSmartLockButton.isEnabled = false
        self.startTimer()
    }
    
    var timer:Timer? = nil
    var times:Int = 5
    var time: Int = -1
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.go), userInfo: nil, repeats: false)
        
    }
    
    func go(timer:Timer){
        print("Noch \(self.times)")
        statusImage.image = #imageLiteral(resourceName: "statusOpen")
        statusLabel.text = "Geöffnet (\(self.times ))"
        times -= 1
        // call your function
        if times > time {  // set the next timer
            self.startTimer()
        } else {
            statusImage.image = #imageLiteral(resourceName: "statusLocked")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            unlockSmartLockButton.isEnabled = true
            print("Automatisch Gesperrt")
            statusLabel.text = "Gesperrt"
            times = 5
            //self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getNotificationPermission() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
                if granted {
                    print("Notification access now/already granted")
                } else { print(error?.localizedDescription as Any)
                }
            })
        }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let notification = UNMutableNotificationContent()
        
     //   let myMap = map
     //   let attachment: UNNotificationAttachment
     //   attachment = try! UNNotificationAttachment(identifier: "meineBenachrichtigung", url: mapURL, options: .none)
     //   notification.attachments = [attachment]
        
        /*
        for item in self.tabBarController!.tabBar.items! {
            if item.tag == 2 {
                item.badgeValue = "1"
            }
        }
        */
        
        let showAction = UNNotificationAction(identifier: "ShowID", title: "Auf Karte anzeigen", options: [.foreground])
        let category = UNNotificationCategory(identifier: "antoniusapps.CoreDataZwo", actions: [showAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        notification.title = "\(nameLabel.text ?? "Kein Schlossname gefunden")"
        notification.subtitle = "\("Adresse" ?? "Keine Geodaten gefunden")"
        notification.body = "Vergiss nicht, dass du dein Smartlock hier abgeschlossen hast."
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "meineBenachrichtigung", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error as Any)
                completion(false)
            } else {
                completion(true)
            }
        })
    }

    func loadNameItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            nameItems = results as! [NSManagedObject]
            
            nameLabel.text = results[selectedIndex] as? String
            
            for nameItems in results {
                nameLabel.text = (nameItems as AnyObject).value(forKey: "nameItem") as? String
                print("NameItems geladen")
            }
        }
        catch {
            print("error")
        }
    }
    
 /*   func loadNameItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            nameItems = results as! [NSManagedObject]
            for nameItems in results {
                nameLabel.text = (nameItems as AnyObject).value(forKey: "nameItem") as? String
                print("NameItems geladen")
            }
        }
        catch {
            print("error")
        }
    }     */

    
    func loadIdentifierItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PasswordEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            identifierItems = results as! [NSManagedObject]
            for identifierItems in results {
                IDLabel.text = (identifierItems as AnyObject).value(forKey: "identifierItem") as? String
                print("IdentifierItems geladen")
            }
        }
        catch {
            print("error")
        }
    }
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        self.deletingActivityIndicator.isHidden = true
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
     //       locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func showAlertViewForConnectionLoss() {
        let alertController = UIAlertController(title: nil, message: "Die Verbindung zum SmartLock wurde unterbrochen. Überprüfen Sie den Batteriestatus und die Entfernung zum SmartLock.", preferredStyle: .actionSheet)
        let destroyAction = UIAlertAction(title: "Schließen", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
            print("Ansicht abgebrochen")
        }
        alertController.addAction(destroyAction)
        self.present(alertController, animated: true) {
        }
    }

  /*
    var touchIDStateItems = [NSManagedObject]()
    var touchID = Bool()
    
    func loadTouchIDStateItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PasswordEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            touchIDStateItems = results as! [NSManagedObject]
            for touchIDStateItems in results {
                touchIDSwitch.isOn = (touchIDStateItems as AnyObject).value(forKey: "touchIDStateItem") as? String
                print("PasswordTypeItems geladen")
            }
        }
        catch {
            print("error")
        }
    } */

    @IBOutlet weak var statusCell: UITableViewCell!
    
 /*   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
           // tableView.separatorColor = UIColor.clear
        }
        else {
            tableView.separatorColor = UIColor.gray
        }
        return statusCell
    } */
    
    @IBOutlet weak var deletingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var deleteCell: UITableViewCell!
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 5 && indexPath.row == 0 {
            let alertController = UIAlertController(title: nil, message: "Das gewählte SmartLock wirklich unwiederruflich mitsamt Einstellungen entfernen?", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel) { (action) in
                print("Abbrechen")
            }
            alertController.addAction(cancelAction)
            let destroyAction = UIAlertAction(title: "Entfernen", style: .destructive) { (action) in
                print("Löschen")
    //            self.dismissButton.isEnabled = false
                self.unlockSmartLockButton.isEnabled = false
                self.deletingActivityIndicator.isHidden = false
                self.deletingActivityIndicator.startAnimating()
                self.stopActivityIndicator()
                self.deleteCell.accessoryType = .none
                
                func wait() {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
                    let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
                    //     nameItems.deleteObjects(nameItems[indexPath.row] as NSManagedObject)
                    //     let context:NSManagedObjectContext = appDelegate.managedObjectContext
                    managedContext.delete(self.nameItems[(indexPath as NSIndexPath).row] as NSManagedObject)
                    managedContext.delete(self.identifierItems[(indexPath as NSIndexPath).row] as NSManagedObject)
                    self.tableView.endUpdates()
                    //self.tableView.reloadData()
                    self.dismiss(animated: true, completion: nil)
                }
                
                
            }
            alertController.addAction(destroyAction)
            self.present(alertController, animated: true) {
                // ...
            }
            print("didSelectDelete")
        } else {}
    }
    
    func stopActivityIndicator() {
        if #available(iOS 10.0, *) {
            let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                self.deletingActivityIndicator.isHidden = true
                self.deletingActivityIndicator.stopAnimating()
                self.deleteCell.accessoryType = .checkmark
                
                
                
            }
        } else { }
        // Earlier versions
    }

    
}
