//
//  UserTapError.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/8/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

struct UserTapError {
    static let ErrorDomain = "com.usertap"
    
    enum ErrorCode: Int {
        case NotImplemented = 1
        case MissingCredentials
        case InvalidResponse
        case BadRequest
    }
    
    enum ErrorKey: String {
        case RequestClass = "UserTapRequestClass"
        case ErrorData = "UserTapErrorData"
    }
}
