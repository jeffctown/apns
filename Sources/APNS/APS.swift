//
//  APS.swift
//  APNS
//
//  Created by Jeff Lett on 12/19/19.
//

import Foundation

public struct APS: Codable {
    
    public var alert: Alert
    public var badge: Int?
    public var sound: String?
    public var category: String?
    public var contentAvailable: Int?
    public var hasMutableContent: Int?
    
    enum CodingKeys: String, CodingKey {
        case alert
        case badge
        case sound
        case category
        case contentAvailable = "content-available"
        case hasMutableContent = "mutable-content"
    }
    
}
