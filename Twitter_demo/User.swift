//
//  User.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 7/30/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var dictionary: NSDictionary
    var followers: Int?
    var following: Int?
    static let userDidLogoutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_background_image_url"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
        }
        followers = (dictionary["followers_count"] as? Int) ?? 0
        following = (dictionary["following"] as? Int) ?? 0
        
        tagline = dictionary["description"] as? String
        self.dictionary = dictionary
    }
    
    static var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUser") as? NSData
                if let userData = userData{
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                    
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user{
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary, options: [])
                defaults.setObject(data, forKey: "currentUser")
            }else{
                defaults.setObject(nil, forKey: "currentUser")
            }
            
            defaults.synchronize()
        }
    }
    
}
