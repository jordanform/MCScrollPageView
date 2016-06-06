//
//  ViewController.swift
//  MCScrollPageView
//
//  Created by Mick on 2016/6/6.
//  Copyright © 2016年 Mick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// The navigation controller for going to sub-groups
    private let navController = UINavigationController()
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showPageView(sender: AnyObject) {
        let pageVC = MCScrollPageViewController()
        
        // Set property
        pageVC.contentImages = ["iPhone5",
                                "iPhone6",
                                "iPhone6S"]
        pageVC.lblTitle.text = "All iPhone devices!!"
        pageVC.lblMotto.text = "display all the model"
        pageVC.lblDescription.text = "WWDC 2016 is comming soon"
        pageVC.delayTime = 2
        
        self.presentViewController(pageVC, animated: true, completion: nil)
    }

}

