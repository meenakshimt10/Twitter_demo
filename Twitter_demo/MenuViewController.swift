//
//  MenuViewController.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 8/5/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    private var tweetsvc: UIViewController!
    private var profilesvc: UIViewController!
    private var mentionsvc: UIViewController!
    
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tweetsvc = storyBoard.instantiateViewControllerWithIdentifier("TweetsViewController")
        let profilesvc = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController")
        let mentionsvc = storyBoard.instantiateViewControllerWithIdentifier("MentionsViewController")
        
        viewControllers.append(profilesvc)
        viewControllers.append(tweetsvc)
        viewControllers.append(mentionsvc)
        hamburgerViewController.contentViewController = profilesvc
        
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell", forIndexPath: indexPath) as! MenuTableViewCell
        
        let titles = ["Profile", "Timeline", "Mentions"]
        cell.menuTitle.text = titles[indexPath.row]
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
    

}
