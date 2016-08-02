//
//  ReplyViewController.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 8/1/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if User.currentUser != nil {
            usernameLabel.text = User.currentUser!.screenname as? String
        
            var profileUrl = User.currentUser!.profileUrl
            if let profileUrl = profileUrl{
            
                userImage.setImageWithURL(profileUrl)
            }
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
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        var text = tweetTextField.text! as String
        TwitterClient.sharedInstance.postTweet(text)
    }

}
