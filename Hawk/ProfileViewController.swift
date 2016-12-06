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
   let background =  UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        let god = self.tabBarController as! GodViewController
        let username = god.username
        self.navigationItem.title = "Me"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red:33/250, green:33/250, blue:33/250, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .orange
        self.reviewsTable.delegate = self
        self.reviewsTable.dataSource = self
        self.reviewsTable.backgroundColor = background
        usernameLabel.text = username
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.view.backgroundColor = background
        self.navigationController?.navigationBar.barTintColor = background
        self.usernameLabel.textColor = .white
        self.avgRatingLabel.textColor = .orange
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let god = self.tabBarController as! GodViewController
        let username = god.username
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RatingTableViewCell
        cell.backgroundColor = UIColor.init(red:33/255, green:33/255, blue:33/255, alpha: 1.0)
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
        cell.ratingTable?.textColor = .orange
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
