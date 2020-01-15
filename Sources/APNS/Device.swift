//
//  Device.swift
//  APNS
//
//  Created by Jeff Lett on 12/19/19.
//


public final class Device: Codable, Equatable {
    
    public static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id: String?
    public var type: String
    public var environment: APNS.Environment
    public var bundleIdentifier: String
    public var pushType: APNS.PushType
    
    public init(id: String, type: String, bundleIdentifier: String, environment: APNS.Environment = .release, pushType: APNS.PushType = .alert) {
        self.id = id
        self.type = type
        self.environment = environment
        self.bundleIdentifier = bundleIdentifier
        self.pushType = pushType
    }
}

