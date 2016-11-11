//
//  UserTapRequest.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/5/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import Foundation

class UserTapRequest {
    static let kUserTapBaseUrl = "usertap_base_url"
    
    static let BASE_URL = "https://api.usertap.com/api/1.0"
    
    lazy var baseUrl:String = {
        if let dict = Bundle.main.infoDictionary, let baseUrl = dict[UserTapRequest.kUserTapBaseUrl] as? String {
            return baseUrl
        }
        return BASE_URL
    }()
    
    func send(completionHandler: ((Any?,NSError?) -> Void)?) {
        print( "[UserTap Warning] send is not implemented for \(type(of:self))")
        let error = NSError(domain: UserTapError.ErrorDomain,
                            code: UserTapError.ErrorCode.NotImplemented.rawValue,
                            userInfo: [UserTapError.ErrorKey.RequestClass.rawValue:type(of:self)])
        completionHandler?(nil, error)
    }
    
    func post(action:String, json:AnyObject, completionHandler:((Any?, NSError?) -> Void)?) {
        print("\(type(of:self)) - post ENTER")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let url = URL(string: "\(self.baseUrl)/\(action)")
        
        var request:URLRequest? = nil
        
        if let url = url {
            request = URLRequest(url: url, cachePolicy:.useProtocolCachePolicy)
        }
        
        if var request = request {
            guard let apiKey = UserTap.sharedInstance.apiKey,
                let appId = UserTap.sharedInstance.appId else {
                    let error = NSError(domain: UserTapError.ErrorDomain,
                                        code: UserTapError.ErrorCode.MissingCredentials.rawValue,
                                        userInfo: nil)
                    completionHandler?(nil, error)
                    return
            }

            if  let authorization = "\(appId):\(apiKey)".data(using: String.Encoding.utf8) {
                let base64 = authorization.base64EncodedString()
                request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            do {
                let data = try JSONSerialization.data(withJSONObject: json, options: [])
                request.httpBody = data
            } catch {
            }
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error as? NSError {
                    completionHandler?(nil, error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    let error = NSError(domain: UserTapError.ErrorDomain,
                                        code: UserTapError.ErrorCode.InvalidResponse.rawValue,
                                        userInfo: nil)
                    completionHandler?(nil, error)
                    return
                }

                var responseObject:Any? = nil
                if let data = data {
                    do {
                        responseObject = try JSONSerialization.jsonObject(with: data, options: [])
                    } catch  {
                        print( "[UserTap Warning] unable to parse JSON response.\n\(NSString(data: data, encoding: String.Encoding.utf8.rawValue))")
                    }
                }
                
                if response.statusCode >= 400 {
                    let errorCode = UserTapError.ErrorCode.BadRequest.rawValue
                    var userInfo:[AnyHashable:Any]? = nil
                    if let responseObject = responseObject {
                        userInfo = [UserTapError.ErrorKey.ErrorData.rawValue:responseObject]
                    }
                    let error = NSError(domain:UserTapError.ErrorDomain,
                                        code: errorCode,
                                        userInfo: userInfo)
                    completionHandler?(nil, error)
                    return
                }
                
                completionHandler?(responseObject, nil)
            })
            
            task.resume()
        }
        print("\(type(of:self)) - post EXIT")
    }
}
