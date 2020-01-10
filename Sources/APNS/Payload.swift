//
//  PayloadContent.swift
//  APNS
//
//  Created by Anthony Castelli on 4/6/18.
//

import Foundation

public struct Payload: Codable {
    public var aps: APS
    public var threadId: String?
    public var extra: [String : String]?
}
