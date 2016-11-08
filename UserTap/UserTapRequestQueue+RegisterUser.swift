//
//  UserTapRequestQueue+RegisterUser.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/8/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

extension UserTapRequestQueue {
    func registerUser(userId:String, properties:[String:String]? = nil) {
        let request = UserTapRegisterUserRequest(userId: userId, properties: properties)
        self.enqueue(request: request)
        self.process()
    }
}
