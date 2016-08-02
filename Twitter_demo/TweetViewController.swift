//
//  TweetViewController.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 7/31/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    var tweet : Tweet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retweetsLabel.text = String(tweet.retweetCount) + " Reweets" as? String
        
        favoritesLabel.text = String(tweet.favoritesCount) + " favorites" as? String
        textLabel.text = tweet.text as? String
        usernameLabel.text = tweet.user?.screenname as? String
        
        var profileUrl = tweet.user!.profileUrl
        if let profileUrl = profileUrl{
            
            tweetImage.setImageWithURL(profileUrl)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let navigationViewController = segue.destinationViewController as! UINavigationController
        let tweetViewController    = navigationViewController.topViewController as! ReplyViewController
    }

}
