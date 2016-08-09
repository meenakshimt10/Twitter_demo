//
//  TweetsViewController.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 7/30/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    var tweetDisplayCount : Int = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            for tweet in tweets{
                //print(tweet.text)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let navigationViewController = segue.destinationViewController as! UINavigationController
        let tweetViewController    = navigationViewController.topViewController as! TweetViewController
        let cell = sender as! TwitterTableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        if let tweets = tweets{
            tweetViewController.tweet = tweets[indexPath!.row]
        }
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! TwitterTableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweetViewController = segue.destinationViewController as! TweetViewController
        print(tweets)
        print(indexPath)
        if let tweets = tweets{
            tweetViewController.tweet = tweets[indexPath!.row]
        }
    }
    */
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
    
    @IBAction func onLogoutAction(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
        
    }
    
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
