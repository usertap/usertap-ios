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
    
    private var queue:[UserTapRequest] = []
    
    func enqueue(request:UserTapRequest) {
        let lockQueue = DispatchQueue(label: "com.usertap.RequestQueue")
        lockQueue.sync {
            self.queue.append(request)
        }
    }
    
    func dequeue() -> UserTapRequest? {
        var request:UserTapRequest? = nil
        let lockQueue = DispatchQueue(label: "com.usertap.RequestQueue")
        lockQueue.sync {
            if !self.queue.isEmpty {
                request = self.queue.removeFirst()
            }
        }
        return request
    }

    func peek() -> UserTapRequest? {
        var request:UserTapRequest? = nil
        let lockQueue = DispatchQueue(label: "com.usertap.RequestQueue")
        lockQueue.sync {
            if !self.queue.isEmpty {
                request = self.queue.first
            }
        }
        return request
    }
    
    func size() -> Int {
        var count:Int = 0
        let lockQueue = DispatchQueue(label: "com.usertap.RequestQueue")
        lockQueue.sync {
            count = self.queue.count
        }
        return count
    }

    func process() {
        if let request = self.dequeue() {
            request.send(completionHandler: { [unowned self] (response, error) in
                
            })
        }
    }
}
