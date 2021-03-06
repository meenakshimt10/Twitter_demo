//
//  Tweet.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 7/30/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text : NSString?
    var timestamp : NSDate?
    var retweetCount : Int = 0
    var favoritesCount : Int = 0
    var user : User?
    
    init(dictionary : NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        let userDictionary = dictionary["user"]  as! NSDictionary
        user = User(dictionary: userDictionary)
        
    }
    
    
    class func tweetsWithArray(dictionaries : [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}


