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
    @IBOutlet weak var mapButtonView: UIView!
    
    var locationNames = [NSManagedObject]()
    var locationLatitude = [NSManagedObject]()
    var locationLongitude = [NSManagedObject]()
    
    var locationManager: CLLocationManager!
    
    let location = CLLocationCoordinate2DMake(51.06415,	13.75706)
    let annotation = MKPointAnnotation()
    
    func showLocationAnntotaions() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // CoreData Delegate
        let managedContext = appDelegate.managedObjectContext // CoreData AppDelegate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NameEntity") // CoreData Entity
        do {
            let results = try managedContext.fetch(fetchRequest)
            locationNames = results as! [NSManagedObject] // Schlössernamen als CoreData
            for locationNames in results {
        //        annotation.title = "\((locationNames as AnyObject).value(forKey: "nameItem") as! String)"
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
        self.mapButtonView.layer.cornerRadius = 15
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
    
    @IBAction func showLocation(_ sender: UIButton) {
        self.viewDidLoad()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let regionToZoom = MKCoordinateRegionMake((manager.location?.coordinate)!, MKCoordinateSpanMake(10,10))
        MapView.setRegion(regionToZoom, animated: true)
        locationManager.stopUpdatingLocation()
  
 /*   CLGeocoder().reverseGeocodeLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            else if (placemarks?.count)! > 0 {
                let pm = placemarks![0]
                let address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
                print("\n\(address)")
                if (pm.areasOfInterest?.count)! > 0 {
                    let areaOfInterest = pm.areasOfInterest?[0]
                    print(areaOfInterest!)
                } else {
                    print("No area of interest found.")
                }
            }
        })
    }*/
    
    }}
