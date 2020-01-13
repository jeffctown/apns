//
//  Shell.swift
//  APNSVapor
//
//  Created by Nathan Tannar on 2018-08-22.
//

import Vapor

///Currently using Bash.
public final class Shell: Service {
    
    // MARK: - Initialization
    
    public init(worker: Container) throws{
        self.worker = worker
    }
    
    // MARK: - Public
    
    public typealias ShellResult = (Int32, Data)
        
    func execute(commandName: String, arguments: [String] = []) throws -> Future<ShellResult> {
        return try bash(commandName: commandName, arguments:arguments)
    }
    
    // MARK: - Private
    
    private var worker: Container
    
    private func bash(commandName: String, arguments: [String]) throws -> Future<ShellResult> {
        return executeShell(command: "/bin/bash" , arguments:[ "-l", "-c", "which \(commandName)" ])
            .map(to: String.self) { exitCode, data in
                switch exitCode {
                case 0:
                    guard let commandPath = String(data: data, encoding: .utf8) else {
                        throw ShellError.commandNotFound
                    }
                    return commandPath.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
                default:
                    throw ShellError.commandNotFound
                }
        }.flatMap(to: ShellResult.self) { path in
                return self.executeShell(command: path, arguments: arguments)
        }
    }
    
    private func executeShell(command: String, arguments: [String] = []) -> Future<ShellResult> {
        return Future.map(on: worker) {
            let process = Process()
            process.launchPath = command
            process.arguments = arguments
            print("\(command) \(arguments.joined(separator: " "))")
                
            let pipe = Pipe()
            process.standardOutput = pipe
            process.launch()
            process.waitUntilExit()
            let result = process.terminationStatus
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return (result, data)
        }
    }
}

extension Shell: ServiceType {
    public static func makeService(for worker: Container) throws -> Shell {
        return try Shell(worker: worker)
    }
}

