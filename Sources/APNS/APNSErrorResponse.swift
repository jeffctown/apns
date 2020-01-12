//
//  APNSErrorResponse.swift
//  
//
//  Created by Jeff Lett on 1/12/20.
//

import Foundation

public struct APNSErrorResponse: Codable {
    public var reason: APNSError
}
