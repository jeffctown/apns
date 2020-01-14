//
//  ArgumentGenerator.swift
//  
//
//  Created by Jeff Lett on 1/4/20.
//

import APNS
import Vapor

struct CurlArgumentGenerator {
    
    static let sandboxUrl: String = "https://api.development.push.apple.com/3/device/"
    static let releaseUrl: String = "https://api.push.apple.com/3/device/"
    
    func generate(data: Data, device: Device, certificate: APNSVapor.Certificate) throws -> [String] {
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw ShellError.unparseableData
        }
        
        let remoteURL = device.environment == .release ? Self.releaseUrl : Self.sandboxUrl
        
        let arguments = ["-d", "\(jsonString)", "-H", "apns-topic:\(certificate.bundleIdentifier)","-H","apns-push-type:\(device.pushType.string)", "-H", "Content-Type:application/json", "--http2", "--cert", "\(certificate.path):\(certificate.password)", remoteURL + device.token]
        
        return arguments
    }
}

