//
//  RatingTableViewCell.swift
//  Hawk
//
//  Created by Shreyas Hirday on 11/24/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet var ratingTable: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var upvoteBtn: UIButton!
    @IBOutlet var downvoteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
