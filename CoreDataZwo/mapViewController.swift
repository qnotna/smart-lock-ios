//
//  mapViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 01.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import CoreLocation
import MapKit

class mapViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    
    var locationNames = [NSManagedObject]()
    var locationLatitude = [NSManagedObject]()
    var locationLongitude = [NSManagedObject]()
    
    var locationManager: CLLocationManager!
    
    @IBAction func openPopOver(sender: UIBarButtonItem) {
        let popOverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MapPopUpID") as! popUpViewController
        self.addChildViewController(popOverViewController)
        popOverViewController.view.frame = self.view.frame
        self.view.addSubview(popOverViewController.view)
        popOverViewController.didMoveToParentViewController(self)
       }
    
    func showLocationAnntotaions() {
        let location = CLLocationCoordinate2DMake(51.06415,	13.75706)
        let annotation = MKPointAnnotation()

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "NameListEntity") // CoreData Entity
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            locationNames = results as! [NSManagedObject] // Schlössernamen als CoreData
            for locationNames in results {
                annotation.title = "\(locationNames.valueForKey("nameItem") as? String)"
            }
        }
        catch {
            print("error")
        }

        annotation.coordinate = location
    //    annotation.title = "Name"
        annotation.subtitle = "Latitude, Longitude"
        MapView.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.showLocationAnntotaions()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        MapView.showsUserLocation = true
        MapView.delegate = self
       
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let regionToZoom = MKCoordinateRegionMake((manager.location?.coordinate)!, MKCoordinateSpanMake(10,10))
        MapView.setRegion(regionToZoom, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }

}