//
//  UserTapRequestQueue.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/5/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

class UserTapRequestQueue {
    private static let requestQueue = UserTapRequestQueue()
    
    static func getSharedRequestQueue() -> UserTapRequestQueue {
        return UserTapRequestQueue.requestQueue
    }
    
    private let operationQueue:OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    func enqueue(request:UserTapRequest) {
        let lockQueue = DispatchQueue(label: "com.usertap.RequestQueue")
        lockQueue.sync {
            self.operationQueue.addOperation(UserTapRequestOperation(request: request))
        }
    }
    
}
