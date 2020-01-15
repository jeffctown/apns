//
//  Device.swift
//  
//
//  Created by Jeff Lett on 12/20/19.
//

import APNS
import FluentSQLite

public extension Device {
    var records: Children<Device, PushRecord> {
        return children(\.deviceID)
    }
}

extension Device: SQLiteStringModel { }
extension Device: Migration { }
