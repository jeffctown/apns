//
//  APNSError.swift
//  APNS
//
//  Created by Jeff Lett on 1/10/20.
//

import Foundation

public enum APNSError: String, Codable {
    case badCollapseId = "BadCollapseId"
    case badDeviceToken = "BadDeviceToken"
    case badExpirationDate = "BadExpirationDate"
    case badMessageId = "BadMessageId"
    case badPriority = "BadPriority"
    case badTopic = "BadTopic"
    case badPath = "BadPath"
    case badCertificate = "BadCertificate"
    case badCertificateEnvironment = "BadCertificateEnvironment"
    case deviceTokenNotForTopic = "DeviceTokenNotForTopic"
    case duplicateHeaders = "DuplicateHeaders"
    case expiredProviderToken = "ExpiredProviderToken"
    case forbidden = "Forbidden"
    case idleTimeout = "IdleTimeout"
    case internalServerError = "InternalServerError"
    case missingDeviceToken = "MissingDeviceToken"
    case invalidProviderToken = "InvalidProviderToken"
    case methodNotAllowed = "MethodNotAllowed"
    case missingProviderToken = "MissingProviderToken"
    case missingTopic = "MissingTopic"
    case payloadEmpty = "PayloadEmpty"
    case payloadTooLarge = "PayloadTooLarge"
    case tooManyProviderTokenUpdates = "TooManyProviderTokenUpdates"
    case tooManyRequests = "TooManyRequests"
    case topicDisallowed = "TopicDisallowed"
    case serviceUnavailable = "ServiceUnavailable"
    case shutdown = "Shutdown"
    case unknown = "unknown"
    case unregistered = "Unregistered"
    
    public var description: String {
        return self.rawValue
    }
}
