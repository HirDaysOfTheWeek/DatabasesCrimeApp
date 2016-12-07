//
//  CrimesViewController.swift
//  Hawk
//
//  Created by Shreyas Hirday on 11/29/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

/*
 to add: 
    date/time/exact address of crimes?
    maybe a list view 
    me tab: list of own reviews
    date/time/exact address of crimes?
    maybe a list view
    me tab: list of own reviews
    logos!
    more complicated data
        local ratings
            - average rating within 1 mile radius?
	nearby cities with the least crimes (for complicated sql queries ;_;)
    display location of reviews tab
 */

import UIKit
import MapKit
import CoreLocation

class CrimesViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var crimeScore: UILabel!
    @IBOutlet var crimeCount: UILabel!
    @IBOutlet var cityStateLabel: UILabel!
    @IBOutlet var arrestsLabel: UILabel!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background =  UIColor.init(red: 125/255, green: 77/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = background
        locationManager.delegate = self
        locationManager.distanceFilter = 500
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let regionRadius = 1000.0
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
        Networking.getCrimes(lat: lat, lon: lon, radius: 0.1, completionHandler: {
            response, error in
            if error == nil {
                let status = response?.status
                if status == "ok" {
                    let crimes = response?.crimes
                    for crime in crimes! {
                        let annotation = MKPointAnnotation()
                        let radToDegrees = 57.2958
                        let coordinate = CLLocationCoordinate2DMake(crime.lat! * radToDegrees, crime.lon! * radToDegrees)
                        annotation.coordinate = coordinate
                        let details = crime.cityState! + " - " + crime.occurredAt!
                        annotation.title = crime.cType
                        annotation.subtitle = details
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }
        })
        Networking.getCityScore(lat: lat, lon: lon, completionHandler: {
            response, error in
            
            if error == nil {
                let score:Double = response?["score"] as! Double
                self.crimeScore.text = String(format: " Average Review of City: %.4f", score)
                let cs = response?["citystate"] as! String
                self.cityStateLabel.text = " " + cs
            }
        })
        Networking.getCityCrimesCount(lat: lat, lon: lon, window: 3, completionHandler: {
            response, error in
            
            if error == nil {
                let count:Int = response?["count"] as! Int
                let arrests:Int =
                    response?["arrests"] as! Int
                self.crimeCount.text = String(format: " # of Crimes in past 3 months: %d", count)
                self.arrestsLabel.text = String(format: " # of Arrests in past 3 months: %d", arrests + 1)
            }
            
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
