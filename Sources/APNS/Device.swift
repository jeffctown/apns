//
//  Device.swift
//  APNS
//
//  Created by Jeff Lett on 12/19/19.
//


public final class Device: Codable, Equatable {
    
    public static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.id == rhs.id && lhs.type == rhs.type && lhs.token == rhs.token && lhs.environment
            == rhs.environment && lhs.bundleIdentifier == rhs.bundleIdentifier && lhs.pushType == rhs.pushType
    }
    
    public var id: Int?
    public var type: String
    public var token: String
    public var environment: APNS.Environment
    public var bundleIdentifier: String
    public var pushType: APNS.PushType
    
    public init(type: String, token: String, bundleIdentifier: String, environment: APNS.Environment = .release, pushType: APNS.PushType = .alert) {
        self.type = type
        self.token = token
        self.environment = environment
        self.bundleIdentifier = bundleIdentifier
        self.pushType = pushType
    }
}

