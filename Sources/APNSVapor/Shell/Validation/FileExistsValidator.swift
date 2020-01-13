//  
//  FileExistsValidator.swift
//  APNSVapor
//
//  Created by Jeff Lett on 1/5/20.
//

import Foundation
import Vapor
  
struct FileExistsValidator {
    func validate(certPath: String, container: Container) throws -> EventLoopFuture<()> {
        return try Shell(worker: container).execute(commandName: "test", arguments: ["-e", certPath])
            .flatMap({ exitCode, data -> EventLoopFuture<()> in
                switch exitCode {
                case 0:
                    print("Validating File at '\(certPath)' - Valid.")
                    return container.future()
                default:
                    print("Validating File at '\(certPath)' - *** FILE NOT FOUND ***.")
                    print(exitCode)
                    print(data)
                    throw ShellError.fileNotFound(certPath)
                }
            })
    }
}
