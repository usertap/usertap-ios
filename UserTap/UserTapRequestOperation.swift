//
//  UserTapRequestOperation.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/10/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

class UserTapRequestOperation:Operation {
    let request:UserTapRequest

    init(request:UserTapRequest) {
        self.request = request
    }
    
    private var _finished : Bool = false
    override var isFinished : Bool {
        get { return _finished }
        set {
            guard _finished != newValue else { return }
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override func main() {
        print( "is main thread: \(Thread.isMainThread)")
        self.request.send { (_, _) in
            self.isFinished = true
        }
    }
}
