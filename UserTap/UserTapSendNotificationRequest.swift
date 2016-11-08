//
//  UserTapSendNotificationRequest.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/8/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

class UserTapSendNotificationRequest:UserTapRequest {
    let to:[String]
    let message:String
    
    init(to:[String], message:String) {
        self.to = to
        self.message = message
    }
    
    override func send(completionHandler: ((Any?, NSError?) -> Void)?) {
        var data:[String:Any] = [
            "to":self.to,
            "notification":["message":self.message]
        ]
        
        self.post(action: "notification", json: data as AnyObject, completionHandler:completionHandler )
    }
}
