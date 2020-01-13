//
//  PasswordValidator.swift
//  APNSVapor
//
//  Created by Jeff Lett on 1/9/20.
//

import Foundation
import Vapor

struct CertificatePasswordValidator {
    func validate(certPath: String, password: String, container: Container) throws -> EventLoopFuture<()> {
        return try Shell(worker: container).execute(commandName: "openssl", arguments: ["pkey", "-in", certPath, "-passin", "pass:\(password)", "-noout"]).flatMap({ exitCode, data -> EventLoopFuture<()> in
            switch exitCode {
            case 0:
                print("Validating Certificate Password at '\(certPath)' - Valid.")
                return container.future()
            default:
                print("Validating Certificate Password at '\(certPath)' - *** INVALID ***.")
                print(exitCode)
                print(data)
                throw CertificateError.passwordInvalid
            }
        })
    }
}
