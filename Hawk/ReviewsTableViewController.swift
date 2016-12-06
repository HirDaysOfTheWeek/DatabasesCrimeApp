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
    var voted = [Vote]()
    let locationManager = CLLocationManager()
    let blueColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let footer:UIView = UIView.init(frame: .zero)
        self.tableView.tableFooterView = footer
        let backgroundBlue = UIColor.init(red: 125/255, green: 77/255, blue: 255/255, alpha: 1.0)
        //let backgroundBlue = UIColor.init(red: 53/255, green: 10/255, blue: 109/255, alpha: 1.0)
        self.view.backgroundColor = backgroundBlue
        self.navigationItem.title = "Reviews"
        self.navigationController?.navigationBar.barTintColor = backgroundBlue
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goToPostReview))
        locationManager.delegate = self
        locationManager.distanceFilter = 1000
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
        var vote : Vote!
        cell.upvoteBtn.setTitle("Upvote", for: .normal)
        cell.upvoteBtn.isEnabled = true
        cell.upvoteBtn.isHidden = false
        cell.downvoteBtn.setTitle("Downvote", for: .normal)
        cell.downvoteBtn.isEnabled = true
        cell.downvoteBtn.isHidden = false
        for v in self.voted {
            if v.rId == review.rId {
                print("rId in voted = \(v.rId) and rId in review = \(review.rId) for row \(row) with comment \(review.comments)")
                vote = v
                break
            }
        }
        if vote != nil {
            let val = vote.vote
            if val == 1 {
                cell.upvoteBtn.setTitle("Upvoted", for: .normal)
                cell.upvoteBtn.isEnabled = false
                cell.downvoteBtn.isHidden = true
            } else {
                cell.downvoteBtn.setTitle("Downvoted", for: .normal)
                cell.downvoteBtn.isEnabled = false
                cell.upvoteBtn.isHidden = true
            }
        }
        let userIdStr = "User: " + review.userId!
        cell.usernameLabel?.text = userIdStr
        cell.usernameLabel?.textColor = .white
        let commentStr = "Comments: " + review.comments!
        cell.commentsLabel?.text = commentStr
        cell.commentsLabel?.textColor = .white
        let ratingStr:String = String(format: "Rating: %.2f", review.rating!)
        cell.ratingTable?.text = ratingStr
        cell.ratingTable?.textColor = .white
        cell.backgroundColor = UIColor.init(red: 53/255, green: 10/255, blue: 109/255, alpha: 1.0)
        cell.upvoteBtn.tag = row
        cell.downvoteBtn.tag = -1 * row
        cell.upvoteBtn.addTarget(self, action: #selector(self.upvote(sender:)), for: .touchUpInside)
        cell.downvoteBtn.addTarget(self, action: #selector(self.downvote(sender:)), for: .touchUpInside)
        //blueColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row = \(indexPath.row)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    var once = true
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
                    if (self.once) {
                        let god = self.navigationController?.tabBarController as? GodViewController
                        let username = god?.username
                        Networking.getVotes(userId: username!, completionHandler: {
                            res, err in
                            if res != nil {
                                print("Has votes")
                                self.voted = (res?.votes)!
                            } else {
                                print("res is nil")
                                if err != nil {
                                    print("err = \(err?.localizedDescription)")
                                }
                            }
                            self.tableView.reloadData()
                            self.once = false
                        })
                    } else {
                        self.reviews = r
                        self.tableView.reloadData()
                    }
                }
            }
            else {
                let message = response?.message
                print("Error, message = \(message)")
            }
        })
    }

    func upvote(sender: UIButton!) {
        print("upvoted")
        let tag = sender.tag
        let review = self.reviews[tag]
        let rId = review.rId
        let god = self.navigationController?.tabBarController as! GodViewController
        let userId = god.username
        Networking.voteReview(rId: rId!, userId: userId!, upvote: true, completionHandler: {
            response, error in
            if error == nil {
                let status = (response?["status"] as! String)
                print("status =\(status)")
                if status == "ok" {
                    let vote = Vote(rId : rId!, userId: userId!, vote: 1)
                    self.voted.append(vote)
                    self.tableView.reloadData()
                }
            } else {
                print("error = \(error?.localizedDescription)")
            }
        })
    }
    
    func downvote(sender: UIButton) {
        let tag = sender.tag
        let inverseTag = -1 * tag
        let review = self.reviews[inverseTag]
        let rId = review.rId
        let god = self.navigationController?.tabBarController as! GodViewController
        let userId = god.username
        Networking.voteReview(rId: rId!, userId: userId!, upvote: false, completionHandler: {
            response, error in
            
            if error == nil {
                let status = (response?["status"] as! String)
                if status == "ok" {
                   let vote = Vote(rId: rId!, userId: userId!, vote: -1)
                   self.voted.append(vote)
                   self.tableView.reloadData()
                }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = self.navigationController?.tabBarController as! GodViewController
        let username = tabBarController.username
        let destination = segue.destination.childViewControllers[0] as! PostReviewViewController
        destination.userId = username
    }
    

}
