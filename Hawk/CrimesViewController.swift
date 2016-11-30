//
//  CrimesViewController.swift
//  Hawk
//
//  Created by Shreyas Hirday on 11/29/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CrimesViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                        annotation.title = crime.cType
                        annotation.subtitle = crime.cityState
                        self.mapView.addAnnotation(annotation)
                    }
                }
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
