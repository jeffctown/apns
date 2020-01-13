//
//  CertificateEnvironmentValidator.swift
//  APNSVapor
//
//  Created by Jeff Lett on 1/10/20.
//

import APNS
import Vapor

struct CertificateEnvironmentValidator {
    func validate(certPath: String, environment: APNS.Environment, container: Container) throws -> EventLoopFuture<()> {
        return try Shell(worker: container).execute(commandName: "openssl", arguments: ["verify", certPath]).flatMap({ exitCode, data -> EventLoopFuture<()> in
            guard let jsonString = String(data: data, encoding: .utf8) else {
                throw ShellError.unparseableData
            }
            
            switch environment {
            case .development:
                guard jsonString.contains("Apple Development IOS Push Services") else {
                    print("Invalid Cert: Development CN Not Found: \(jsonString)")
                    throw CertificateError.environmentInvalid
                }
            case .release:
                guard jsonString.contains("Apple Push Services") else {
                    print("Invalid Cert: Production CN Not Found: \(jsonString)")
                    throw CertificateError.environmentInvalid
                }
            }
            
            print("Validating Certificate Environment at '\(certPath)' - Valid.")
            return container.future()
            
        })
    }
}
