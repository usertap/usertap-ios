//
//  NSData+DeviceToken.swift
//  UserTap
//
//  Created by Tobin Schwaiger-Hastanan on 11/5/16.
//  Copyright © 2016 Tobin Schwaiger-Hastanan. All rights reserved.
//

import UIKit

extension Data {
    func hexString() -> String {
        // "Array" of all bytes:
        let bytes = UnsafeBufferPointer<UInt8>(start: (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count), count:self.count)
        // Array of hex strings, one for each byte:
        let hexBytes = bytes.map({ String(format: "%02hhx", $0)})
        // Concatenate all hex strings:
        return hexBytes.joined(separator: "")
    }
}
