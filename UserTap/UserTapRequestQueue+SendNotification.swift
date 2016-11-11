//
//  UserTapQueue+SendNotification.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/8/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

extension UserTapRequestQueue {
    func sendNotification(to:[String], message:String, properties:[String:String]? = nil) {
        let request = UserTapSendNotificationRequest(to: to, message:message, properties:properties)
        self.enqueue(request: request)
    }
}
