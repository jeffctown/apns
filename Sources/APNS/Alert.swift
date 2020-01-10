//
//  Alert.swift
//  APNS
//
//  Created by Jeff Lett on 12/19/19.
//

import Foundation

public struct Alert: Codable {
    
    public var title: String?
    public var subtitle: String?
    public var body: String?
    public var titleLocKey: String?
    public var titleLocArgs: [String]?
    public var bodyLocKey: String?
    public var bodyLocArgs: [String]?
    public var launchImage: String?
    public var actionLocKey: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case body
        case titleLocKey = "title-loc-key"
        case titleLocArgs = "title-loc-args"
        case bodyLocKey = "body-loc-key"
        case bodyLocArgs = "body-loc-args"
        case launchImage = "launch-image"
        case actionLocKey = "action-loc-key"
    }
}
