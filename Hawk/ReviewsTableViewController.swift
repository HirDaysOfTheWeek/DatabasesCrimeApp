//
//  ReviewsTableViewController.swift
//  Hawk
//
//  Created by Shreyas Hirday on 11/23/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import UIKit
import CoreLocation

class ReviewsTableViewController: UITableViewController, CLLocationManagerDelegate {

    var reviews = [Review]()
    let locationManager = CLLocationManager()
    let blueColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let footer:UIView = UIView.init(frame: .zero)
        self.tableView.tableFooterView = footer
        let yellowColor = UIColor.init(red: 255/255, green: 235/255, blue: 59/255, alpha: 1.0)
        self.view.backgroundColor = yellowColor
        self.navigationItem.title = "Reviews"
        self.navigationController?.navigationBar.barTintColor = yellowColor
        self.navigationController?.navigationBar.tintColor = blueColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goToPostReview))
        locationManager.delegate = self
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RatingTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! RatingTableViewCell

        // Configure the cell...
        let row = indexPath.row
        let review = self.reviews[row]
        let userIdStr = "User: " + review.userId!
        cell.usernameLabel?.text = userIdStr
        cell.usernameLabel?.textColor = .white
        let commentStr = "Comments: " + review.comments!
        cell.commentsLabel?.text = commentStr
        cell.commentsLabel?.textColor = .white
        let ratingStr:String = String(format: "Rating: %.2f", review.rating!)
        cell.ratingTable?.text = ratingStr
        cell.ratingTable?.textColor = .white
        cell.backgroundColor = blueColor
        return cell
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
        let radius = 0.1
        Networking.getReviews(lat: lat, lon: lon, radius: radius, completionHandler: {
            response, error in
            
            let status = response?.status
            if status == "ok" {
                if let r = response?.reviews {
                    print("Has reviews")
                    self.reviews = r
                    self.tableView.reloadData()
                }
            }
            else {
                let message = response?.message
                print("Error, message = \(message)")
            }
        })
    }

    func goToPostReview() {
        self.performSegue(withIdentifier: "goToPostReview", sender: self)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
