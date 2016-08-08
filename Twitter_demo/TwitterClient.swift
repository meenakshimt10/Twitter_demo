//
//  TwitterClient.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 7/30/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "Cfm5aBWFtKuR4vZvRskicDyMD", consumerSecret: "OZWGMIcFO0b2YeEdFN8R98aNwbJaA9cNN8NdJRwrc4oVEj7UHx")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeline(success: ([Tweet] -> ()), failure: (NSError) -> ()){
        
            GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (task : NSURLSessionDataTask, response : AnyObject?) -> Void in
                let dictionaries = response as! [NSDictionary]
                let tweets       = Tweet.tweetsWithArray(dictionaries)
                success(tweets)
                
            }, failure: { (task : NSURLSessionDataTask?, error : NSError) -> Void in
                failure(error)
            })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> () ){
            GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task : NSURLSessionDataTask , response : AnyObject?) ->  Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
            print("User: \(user.name)")
            print("name: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("Description: \(user.tagline)")
            }, failure: { (task : NSURLSessionDataTask?, error : NSError) -> Void in
                    failure(error)
                
            })
    }
    
    func postTweet(status:String) {
        let obj = ["status" : "hello world"]
        /*
        POST("1.1/statuses/update.json", parameters: obj,  uploadProgress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("success")
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
                
        })  -> NSURLSessionDataTask in
        print("done")
        
            */
        POST("1.1/statuses/update.json", parameters: obj, success: {(task : NSURLSessionDataTask , response : AnyObject?) -> Void in
            print("sucessfully inserted tweet")
            }, failure: {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("error\(error)")
        })
        print("done")
        
        
    }
    
    func login(success : () -> (), failure :(NSError) -> ()){
        deauthorize()
        loginSuccess = success
        loginFailure = failure
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:  "twitterdemo://oauth"), scope: nil, success: { (requestToken : BDBOAuth1Credential!) -> Void in
                print("I got token")
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
                UIApplication.sharedApplication().openURL(url)
            })
            { (error : NSError!) -> Void in
                self.loginFailure!(error)
            }
    }
    
    func handleOpenUrl(url: NSURL){
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success:{ (accessToken :BDBOAuth1Credential!) -> Void in
            self.currentAccount({ (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                },
                failure: { (error: NSError) -> () in
                    self.loginFailure!(error)
                })
            
            })
        { (error : NSError!) in
            print("error : \(error.localizedDescription)")
            self.loginFailure!(error)
        }
    }

    func logout(){
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    
    
}
