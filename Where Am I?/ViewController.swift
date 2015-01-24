//
//  ViewController.swift
//  Where Am I?
//
//  Created by Akkshay Khoslaa on 12/26/14.
//  Copyright (c) 2014 Akkshay Khoslaa. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var heading: UILabel!
    
    @IBOutlet weak var speed: UILabel!
    
    @IBOutlet weak var altitude: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    var manager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager:CLLocationManager!, didUpdateLocations locations: [AnyObject]) {
        
        var userLocation:CLLocation = locations[0] as CLLocation
        
        latitude.text = "\(userLocation.coordinate.latitude)"
        
        longitude.text = "\(userLocation.coordinate.longitude)"
        
        heading.text = "\(userLocation.course)"
        
        speed.text = "\(userLocation.speed)"
        
        altitude.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) in
            if error != nil {println(error)}
            else {
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                var subThoroughfare:String
                if (p.subThoroughfare != nil) {
                    subThoroughfare = p.subThoroughfare
                } else {
                    subThoroughfare = ""
                }
                self.address.text = "\(p.subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode)  \(p.country)"
                
                
            }
            })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

