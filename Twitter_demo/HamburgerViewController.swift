//
//  HamburgerViewController.swift
//  Twitter_demo
//
//  Created by Meenakshi Muthuraman on 8/5/16.
//  Copyright © 2016 Meenakshi Muthuraman. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var controlView: UIView!
    var originalLeftMargin: CGFloat!
    var menuViewController: UIViewController!{
        didSet{
            view.layoutIfNeeded()
            mainView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController: UIViewController!{
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            
            if oldContentViewController != nil{
                oldContentViewController.willMoveToParentViewController(nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMoveToParentViewController(nil)
            }
            contentViewController.willMoveToParentViewController(self)
            controlView.addSubview(contentViewController.view)
            contentViewController.didMoveToParentViewController(self)
            UIView.animateWithDuration(0.3) { 
                () -> Void in
                self.leftMarginConstrain.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBOutlet weak var leftMarginConstrain: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            originalLeftMargin = leftMarginConstrain.constant
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            leftMarginConstrain.constant = originalLeftMargin+translation.x
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            UIView.animateWithDuration(0.3, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstrain.constant = self.view.frame.size.width - 50
                } else {
                    self.leftMarginConstrain.constant = 0
                }
                //let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                //let vc = storyBoard.instantiateViewControllerWithIdentifier("MenuViewController")
                //self.menuViewController = vc
                self.view.layoutIfNeeded()
                
            })
            
        }
    }

}
