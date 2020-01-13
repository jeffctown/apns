//
//  EnvironmentParameterValidator.swift
//  APNSVapor
//
//  Created by Jeff Lett on 1/5/20.
//

import Foundation
import Vapor

struct EnvironmentParameterValidator {
    func getOrThrow(_ paramName: String) throws -> String {
        guard let parameter = Environment.get(paramName) else {
            throw InitializationError.environmentParameterMissing(paramName)
        }
        return parameter
    }
}
