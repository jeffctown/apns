//
//  APNS.swift
//  APNS
//
//  Created by Jeff Lett on 1/4/20.
//

import Foundation

public struct APNS {
    
    public enum Environment: Int, Codable {
        case development, release
    }
    
    public enum PushType: Int, Codable {
        case alert
        case background
        case complication
        case voip
        case mdm
        case fileprovider
        
        public var string: String {
            switch self {
            case .alert: return "alert"
            case .background: return "background"
            case .complication: return "complication"
            case .voip: return "voip"
            case .mdm: return "mdm"
            case .fileprovider: return "fileprovider"
            }
        }
    }
}
