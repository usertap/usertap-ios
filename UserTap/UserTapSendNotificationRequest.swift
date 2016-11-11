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
    var properties:[String:String]?
    
    init(to:[String], message:String, properties:[String:String]? = nil) {
        self.to = to
        self.message = message
        self.properties = properties
    }
    
    override func send(completionHandler: ((Any?, NSError?) -> Void)?) {
        var notification:[String:Any] = ["message":self.message]
        
        if let properties = self.properties {
            notification["properties"] = properties
        }

        let data:[String:Any] = [
            "to":self.to,
            "notification":notification
        ]
        
        self.post(action: "notification", json: data as AnyObject, completionHandler:completionHandler )
    }
}
