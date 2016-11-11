//
//  UserTapRegisterUserRequest.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/8/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

class UserTapRegisterUserRequest:UserTapRequest {
    let userId:String
    var properties:[String:String]?
    init(userId:String, properties:[String:String]? = nil) {
        self.userId = userId
        self.properties = properties
    }
    
    override func send(completionHandler: ((Any?, NSError?) -> Void)?) {        
        var data:[String:Any] = [
            "userId":self.userId
        ]
        
        if let properties = self.properties {
            data["properties"] = properties
        }
        
        self.post(action: "user", json: data as AnyObject, completionHandler:completionHandler )
    }
    
}
