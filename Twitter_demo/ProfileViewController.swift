//
//  ProfileViewController.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 8/5/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    var tweets: [Tweet]!
    var tweetDisplayCount : Int = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        var profileUrl = User.currentUser!.profileUrl
        if let profileUrl = profileUrl{
            
            profileImage.setImageWithURL(profileUrl)
        }
        print("hh\(User.currentUser!.followers)")
        followersLabel.text = String(User.currentUser!.followers) + "Followers" as? String
        
        followingLabel.text = String(User.currentUser!.following) + "Followers" as? String
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            for tweet in tweets{
                print(tweet.text)
            }
        }) { (error: NSError)-> () in
            print("tweets error:\(error)")
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tweetDisplayCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TwitterCell", forIndexPath: indexPath) as! TwitterTableViewCell
        //print(tweets)
        if let tweets = tweets{
            cell.tweet = tweets[indexPath.row]
        }
        return cell;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.tweetDisplayCount = self.tweetDisplayCount + 20
            refreshControl.endRefreshing()
            print("\(self.tweetDisplayCount)")
        }) { (error: NSError)-> () in
            print("tweets error:\(error)")
        }
    }

}
