//
//  TwitterTableViewCell.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 7/30/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit
import AFNetworking

class TwitterTableViewCell: UITableViewCell {
    

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var tweettextLabel: UILabel!
    
    
    var tweet : Tweet!{
        didSet{
            retweetsLabel.text = String(tweet.retweetCount) as? String
            tweettextLabel.text = tweet.text as? String
            usernameLabel.text = tweet.user?.screenname as? String
            
            var profileUrl = tweet.user!.profileUrl
            if let profileUrl = profileUrl{
                
                profileImage.setImageWithURL(profileUrl)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
