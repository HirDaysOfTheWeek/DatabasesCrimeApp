//
//  ReviewDetailViewController.swift
//  Hawk
//
//  Created by Shreyas Hirday on 12/6/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import UIKit

class ReviewDetailViewController: UIViewController {

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var commentsLabel: UITextView!
    
    var username : String!
    var rating : String!
    var comments : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameLabel.text = self.username
        self.ratingLabel.text = self.rating
        self.commentsLabel.text = self.comments
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.done, target: self, action: #selector(goBack))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func goBack() {
        self.dismiss(animated: true, completion: nil)
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
