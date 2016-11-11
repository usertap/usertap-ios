//
//  UserTap.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/4/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import UIKit
import UserNotifications

class UserTap {
    enum DefaultsKey: String {
        case UserId = "UserTapUserId"
    }

    static let sharedInstance = UserTap()
    
    var appId:String? = nil
    var apiKey:String? = nil
    var deviceToken:Data? = nil
    
    static func initWithLaunchOptions(_ launchOptions:[UIApplicationLaunchOptionsKey: Any]?, appId:String, apiKey:String) {
        UserTap.sharedInstance.initWithLaunchOptions(launchOptions, appId: appId, apiKey: apiKey)
    }
    
    static func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        UserTap.sharedInstance.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func initWithLaunchOptions(_ launchOptions:[UIApplicationLaunchOptionsKey:Any]?, appId:String, apiKey:String) {
        self.appId = appId
        self.apiKey = apiKey
        
        if self.isRegisteredForRemoteNotifications() {
            self.registerForRemoteNotifications()
        }
    }
    
    static func registerUser(userId:String, properties:[String:String]? = nil) {
        if userId.characters.count == 0 {
            clearUser()
            return
        }

        let defaults = UserDefaults.standard
        defaults.set(userId, forKey: DefaultsKey.UserId.rawValue)
        defaults.synchronize()

        if let deviceToken = self.sharedInstance.deviceToken {
            UserTapRequestQueue.getSharedRequestQueue().registerEndpoint(deviceToken: deviceToken.hexString(), userId:UserTap.getUserId(), properties:properties)
        } else {
            UserTapRequestQueue.getSharedRequestQueue().registerUser(userId: userId, properties:properties)
        }
    }
    
    static func clearUser() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: DefaultsKey.UserId.rawValue)
        defaults.synchronize()
    }
    
    static func getUserId() -> String? {
        let defaults = UserDefaults.standard
        
        if let userId = defaults.object(forKey: DefaultsKey.UserId.rawValue) as? String {
            return userId
        }
        
        return nil
    }
    
    static func sendNotification(to:[String], message:String, properties:[String:String]? = nil) {
        UserTapRequestQueue.getSharedRequestQueue().sendNotification(to: to, message: message, properties:properties)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.deviceToken = deviceToken
        UserTapRequestQueue.getSharedRequestQueue().registerEndpoint(deviceToken: deviceToken.hexString(), userId:UserTap.getUserId())
    }
    
    func isRegisteredForRemoteNotifications() -> Bool {
        let application = UIApplication.shared
        
        if application.isRegisteredForRemoteNotifications {
            return true
        }
        
        return false
    }

    func registerForRemoteNotifications() {
        let application = UIApplication.shared
  
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            if( granted ) {
                application.registerForRemoteNotifications()
            }
        }
    }
}
