//
//  UserTapQueue+SendNotification.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/8/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

extension UserTapRequestQueue {
    func sendNotification(to:[String], message:String) {
        let request = UserTapSendNotificationRequest(to: to, message:message)
        self.enqueue(request: request)
        self.process()
    }
}
