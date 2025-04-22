//
//  UIDevice+Ext.swift
//  Runner
//
//  Created by Hemming on 2025/4/22.
//

import Foundation
import AppTrackingTransparency
import AdSupport

extension UIDevice {
    static func getDeviceIdentifier ( DeviceBlock: @escaping (_ str: String) -> Void ) {
        
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                if status == .authorized {
                    DeviceBlock(UIDevice.getDeviceRawAdvertisingId())
                } else {
                    IdentifierBlock("00000000-0000-0000-0000-000000000000")
                }
            })
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                DeviceBlock(UIDevice.getDeviceRawAdvertisingId())
            } else {
                DeviceBlock("00000000-0000-0000-0000-000000000000")
            }
        }
    }
    
    static func getDeviceRawAdvertisingId() -> String {
        var deviceIdentifier = "00000000-0000-0000-0000-000000000000"
        let adIdentifier =  ASIdentifierManager.shared().advertisingIdentifier
        if adIdentifier.uuidString.isValidStr {
            deviceIdentifier = adIdentifier.uuidString
        }
        return deviceIdentifier
    }
}
