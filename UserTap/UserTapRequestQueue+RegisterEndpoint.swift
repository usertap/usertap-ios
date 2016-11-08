//
//  UserTapRequestQueue+RegisterDevice.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/7/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

extension UserTapRequestQueue {
    func registerEndpoint(deviceToken:String, userId:String? = nil) {
        #if DEBUG
            let type = "ios_dev"
        #else
            let type = "ios"
        #endif
        let request = UserTapRegisterEndpointRequest(deviceToken: deviceToken, type:type, userId:userId)
        self.enqueue(request: request)
        self.process()
    }
}
