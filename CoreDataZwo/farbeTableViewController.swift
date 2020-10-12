//
//  farbeTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 04.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import UIKit
import CoreData

class farbeTableViewController : UITableViewController {
    
    @IBAction func dismissModalViewController(_ sender: UIBarButtonItem) {
        self.saveRedItems()
        self.saveGreenItems()
        self.saveBlueItems()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var rotSlider: UISlider!
    @IBOutlet weak var grünSlider: UISlider!
    @IBOutlet weak var blauSlider: UISlider!
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func rotSliderAction(_ sender: UISlider) {
        changeColors()
    }
    @IBAction func grünSliderAction(_ sender: UISlider) {
        changeColors()
    }
    @IBAction func blauSliderAction(_ sender: UISlider) {
        changeColors()
    }

    var rot: Float = 0.5
    var grün: Float = 0.5
    var blau: Float = 0.5
    
    var rotItems = [NSManagedObject]()
    var grünItems = [NSManagedObject]()
    var blauItems = [NSManagedObject]()
    
    func displayLabelDidChangeColor() {
         displayLabel.backgroundColor = UIColor(red: CGFloat(rot), green: CGFloat(grün), blue: CGFloat(blau), alpha: 1.0)
    }
    
    func changeColors() {
        rot = rotSlider.value
        grün = grünSlider.value
        blau = blauSlider.value
        displayLabelDidChangeColor()
        
        // print("\(displayLabel.backgroundColor!)") //as UIColor)")
        
        let rotString = rot.description
        let grünString = grün.description
        let blauString = blau.description
        
        print("Rot: \(rotString), Grün: \(grünString), Blau: \(blauString), Alpha: 1.0")
        
        /*
        print(rot.description)

        let rotFloat = (rotString as NSString).floatValue
        print(rotFloat)
       // displayLabel.backgroundColor = UIColor(red: rotString, green: grünString, blue: blauString, alpha: 1.0)
        */
 
    }
    
    func saveRedItems() {
        
        rot = rotSlider.value
        // displayLabelDidChangeColor()
        
        let rotString = rot.description
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let entity = NSEntityDescription.entity(forEntityName: "ColorEntity", in: managedContext) // CoreData Entity
        let item = NSManagedObject(entity: entity!, insertInto: managedContext) // Speichern als CoreData Entity
        item.setValue(rotString, forKey: "redItem") // CoreData Attribute
        do {
            try managedContext.save()
            print("saved colorItems as R\(rotItems)")
        } catch {
            print ("Error")
        }
    }
    func saveGreenItems() {
        
        grün = grünSlider.value
        // displayLabelDidChangeColor()
        
        let grünString = grün.description
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let entity = NSEntityDescription.entity(forEntityName: "ColorEntity", in: managedContext) // CoreData Entity
        let item = NSManagedObject(entity: entity!, insertInto: managedContext) // Speichern als CoreData Entity
        item.setValue(grünString, forKey: "greenItem") // CoreData Attribute
        do {
            try managedContext.save()
            print("saved colorItems as G\(grünItems)")
        } catch {
            print ("Error")
        }
    }
    func saveBlueItems() {
        
        blau = blauSlider.value
        // displayLabelDidChangeColor()
        
        let blauString = blau.description
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let entity = NSEntityDescription.entity(forEntityName: "ColorEntity", in: managedContext) // CoreData Entity
        let item = NSManagedObject(entity: entity!, insertInto: managedContext) // Speichern als CoreData Entity
        item.setValue(blauString, forKey: "blueItem") // CoreData Attribute
        do {
            try managedContext.save()
            print("saved colorItems as B\(blauItems)")
        } catch {
            print ("Error")
        }
    }

    override func viewDidLoad() {
        displayLabel.layer.masksToBounds = true
        displayLabel.layer.cornerRadius = 12.5
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
