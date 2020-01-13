//
//  PushRecordController.swift
//  App
//
//  Created by Jeff Lett on 7/5/19.
//

import APNS
import Vapor

public final class PushRecordController {
    
    public init() {}
    
    public func read(_ req: Request) throws -> Future<[PushRecord]> {
        return try req.parameters.next(Device.self).flatMap({ device in
            return try device.records.query(on: req).all()
        })
    }
    
    public func index(_ req: Request) throws -> Future<[PushRecord]> {
        return PushRecord.query(on: req).sort(\.id, .descending).all()
    }
    
}
