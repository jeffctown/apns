//
//  PushRecord.swift
//  APNS
//
//  Created by Jeff Lett on 1/10/20.
//

import Foundation

public final class PushRecord: Codable {
    
    public enum DeliveryStatus: Int, Codable {
        case deliveryFailed = 1
        case delivered = 0
    }
    
    // MARK: - Properties
    
    public var id: Int?
    public var deviceID: Int
    public var createdAt: Date?
    public var updatedAt: Date?
    public var deletedAt: Date?
    public var payload: String
    public var status: DeliveryStatus
    public var error: String?
    
    // MARK: - Initialization
    
    public init(payload: String, status: DeliveryStatus, deviceID: Int, date: Date = Date()) {
        self.payload = payload
        self.status = status
        self.deviceID = deviceID
        self.createdAt = date
    }
    
    public init(payload: String, error: APNSError, deviceID: Int, date: Date = Date()) {
        self.payload = payload
        self.status = .deliveryFailed
        self.error = error.rawValue
        self.deviceID = deviceID
        self.createdAt = date
    }
    
}
