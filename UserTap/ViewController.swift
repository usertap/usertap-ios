//
//  ViewController.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/4/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enableNotification(sender:AnyObject) {
        UserTap.sharedInstance.registerForRemoteNotifications()
    }

}

