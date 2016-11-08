//
//  UserTapRegisterEndpointRequest.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/7/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

class UserTapRegisterEndpointRequest:UserTapRequest {
    let deviceString:String
    let type:String
    var userId:String? = nil
    
    init(deviceToken:String, type:String, userId:String? = nil) {
        self.deviceString = deviceToken
        self.type = type
        self.userId = userId
    }
    
    override func send(completionHandler: ((Any?, NSError?) -> Void)?) {
        var data:[String:Any] = [
            "identifier":self.deviceString,
            "type":self.type
        ]
        
        if let userId = self.userId {
            let user = ["userId":userId]
            data["user"] = user
        }
        
        self.post(action: "endpoint", json: data as AnyObject, completionHandler:completionHandler )
    }
    
}
