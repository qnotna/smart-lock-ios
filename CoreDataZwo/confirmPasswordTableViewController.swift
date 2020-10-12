//
//  confirmPasswordTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 30/09/2016.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import LocalAuthentication

class confirmPasswordTableViewController : UITableViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var passwordItems = [NSManagedObject]()
    var nameItems = [NSManagedObject]()
    var nameItem = String()
    
    func loadNameItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameEntity")
        do {
            let results = try managedContext.fetch(fetchRequest)
            nameItems = results as! [NSManagedObject]
            for nameItems in results {
                nameItem = (nameItems as AnyObject).value(forKey: "nameItem") as! String
                print("NameItems geladen als \(nameItem)")
            }
        }
        catch {
            print("error")
        }
    }

    
    @IBAction func dismissModalViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {
            self.dismiss(animated: true, completion: nil) // funzt nicht
        })
    }
    
    @IBAction func doneDismissingViewController(_ sender: UIBarButtonItem) {
        if passwordTextField.text == passwordItems as? String {
            self.dismiss(animated: true, completion: nil)
        } else {}
    }
    
    override func viewDidAppear(_ animated: Bool) {
        passwordTextField.becomeFirstResponder()
        loadTouchID()
    }

    func loadTouchID() {
        let authentificationContext = LAContext()
        if authentificationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            authentificationContext.evaluatePolicy(LAPolicy(rawValue: Int(kLAPolicyDeviceOwnerAuthenticationWithBiometrics))!, localizedReason: "SmartLock \(nameItem as String) entsperren", reply: { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    if let error = error as? NSError {
                        let message = self.errorMessageforLAErrorCode(errorCode: error.code)
                        self.showAlertViewAfterEvaluatingPolicyWithMessage(message: message)
                    }
                }
            })
        } else {
            showAlertViewForNoBiometrics()
            return
        }
    }
    
    func showAlertViewAfterEvaluatingPolicyWithMessage(message: String) {
        showAlertWithTitle(title: "Fehler", message: message)
    }
    
    func errorMessageforLAErrorCode(errorCode: Int) -> String {
        var message = ""
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Authentifizeirung wurde von der App unterbrochen"
        case LAError.authenticationFailed.rawValue:
            message = "Der Benutzer hat keine gültigen Anmeldeinformationen angegeben"
        case LAError.invalidContext.rawValue:
            message = "Ungültiger Kontext"
        case LAError.passcodeNotSet.rawValue:
            message = "Es wurde kein Password angegeben"
        case LAError.systemCancel.rawValue:
            message = "Authentifizeirung wurde vom System unterbrochen"
        case LAError.touchIDLockout.rawValue:
            message = "Zu viele fehlgeschlagene Versuche"
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID wird auf diesem Gerät nicht unterstützt"
        case LAError.userCancel.rawValue:
            message = "Authentifizeirung wurde vom Nutzer unterbrochen"
        case LAError.userFallback.rawValue:
            message = "Der Nutzer hat Alternativeingabe gewählt"
        default:
            message = "Kein LAErrorObject gefunden"
        }
        return message
    }
    
    func showAlertViewForNoBiometrics() {
        showAlertWithTitle(title: "Fehler", message: "TouchID wird auf diesem Gerät nicht unterstützt")
    }
    
    func showAlertWithTitle(title: String, message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
}
