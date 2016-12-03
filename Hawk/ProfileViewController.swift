//
//  ProfileViewController.swift
//  Hawk
//
//  Created by Tanya B on 11/23/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var avgRatingLabel: UILabel!
    @IBOutlet weak var reviewsTable: UITableView!
    var reviews = [Review]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let god = self.tabBarController as! GodViewController
        let username = god.username
        self.reviewsTable.delegate = self
        self.reviewsTable.dataSource = self
        self.reviewsTable.isHidden = true
        usernameLabel.text = username
        let background =  UIColor.init(red: 125/255, green: 77/255, blue: 255/255, alpha: 1.0)
        self.view.backgroundColor = background
        self.navigationController?.navigationBar.barTintColor = background
        self.usernameLabel.textColor = .white
        self.avgRatingLabel.textColor = .white
        Networking.getReviewsByUserId(userId: username!, completionHandler: {response, error in
            
            let status = response?.status
            if status == "ok" {
                self.reviews = (response?.reviews)!
                var total = 0.0
                for review in self.reviews {
                    print("rating = \(review.rating!)")
                    total += review.rating!
                }
                print("total = \(total)")
                let count = Double((self.reviews.count))
                print("count = \(count)")
                let avg:Double = total/count
                let avgStr = String(format: "Average Rating: %1.2f", avg)
                self.avgRatingLabel.text = avgStr
                self.reviewsTable.reloadData()
            }
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.reviews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! RatingTableViewCell
        
        // Configure the cell...
        let row = indexPath.row
        let review = self.reviews[row]
        let userIdStr = "User: " + review.userId!
        cell.usernameLabel?.text = userIdStr
        let commentStr = "Comments: " + review.comments!
        cell.commentsLabel?.text = commentStr
        let ratingStr:String = String(format: "Rating: %.2f", review.rating!)
        cell.ratingTable?.text = ratingStr
        return cell
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
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
