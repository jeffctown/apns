import APNS
import APNSFluent
import Vapor

public struct APNSVapor {
    
    public struct Certificate {
        let environment: APNS.Environment
        let path: String
        var password: String
        var bundleIdentifier: String
        
        public init(environment: APNS.Environment, path: String, bundleIdentifier: String, password: String = "") {
            self.environment = environment
            self.path = path
            self.bundleIdentifier = bundleIdentifier
            self.password = password
        }
        
        ///this method is synchronous
        public func validatePassword(container: Container) throws {
            try CertificatePasswordValidator().validate(certPath: path, password: password, container: container).wait()
        }
        
        ///this method is synchronous
        public func validateCertFileExists(container: Container) throws {
            try FileExistsValidator().validate(certPath: path, container: container).wait()
        }
        
    }
    
    let certificates: [Certificate]
    
    public init(certificates: [Certificate]) throws {
        self.certificates = certificates
    }
    
    public func validatePasswords(container: Container) throws {
        try certificates.forEach {
            try $0.validatePassword(container: container)
        }
    }
    
    public func validateFilesExist(container: Container) throws {
        try certificates.forEach {
            try $0.validateCertFileExists(container: container)
        }
    }
    
    public func push(_ req: Request, _ payload: Data) throws -> Future<[PushRecord]> {
        let logger = try req.make(Logger.self)
        return Device.query(on: req).all().flatMap(to: [PushRecord].self) { devices in
            logger.info("Sending Push to \(devices.count) devices.")
            logger.info("Payload: \(payload)")
            return devices.compactMap {
                guard let id = $0.id else {
                    print("Error: No Device identifier to push.")
                    return nil
                }
                
                logger.info("Pushing to \(id)")
                do {
                    return try self.pushToDevice(token: id, device: $0, data: payload, req: req)
                } catch {
                    logger.error("Error Pushing to Device Token \(error)")
                }
                return nil
            }.flatten(on: req)
        }
    }
    
    private func certificate(for bundleIdentifier: String, environment: APNS.Environment) throws -> Certificate {
        let certificate = certificates.first { $0.bundleIdentifier == bundleIdentifier && $0.environment == environment }
        guard let cert = certificate else {
            throw CertificateError.unsupportedBundleIdentifier
        }
        return cert
    }
        
    public func pushToDevice(token: String, device: Device, data: Data, req: Request) throws -> Future<PushRecord> {
        let logger = try req.make(Logger.self)
        let shell = try req.make(Shell.self)
        let argumentGenerator = CurlArgumentGenerator()
        let cert = try certificate(for: device.bundleIdentifier, environment: device.environment)
        let arguments = try argumentGenerator.generate(data: data, device: device, token: token, certificate: cert)
        let readableArguments = arguments.joined(separator: " ")
        logger.debug(readableArguments)
        
        return try shell.execute(commandName: "curl", arguments: arguments).flatMap(to: PushRecord.self) { exitCode, responseData in
            do {
                print("Result: \(exitCode)")
                print("ResponseData: \(responseData.count) \(responseData)")
                
                guard responseData.count > 0 else {
                    let record = PushRecord(payload: readableArguments, status: .delivered, deviceToken: device.id!)
                    return record.save(on: req)
                }
                
                let decoder = JSONDecoder()
                let errorResponse = try decoder.decode(APNSErrorResponse.self, from: responseData)
                let error = errorResponse.reason
                logger.error(error.rawValue)
                let record = PushRecord(payload: readableArguments, error: error, deviceToken: device.id!)
                return record.save(on: req)
            } catch _ {
                let errorMessage = String(data: data, encoding: .utf8)
                logger.error("Unknown Error Parsing Curl Error. \(errorMessage ?? "nil") \(data.count)")
                let record = PushRecord(payload: readableArguments, error: .unknown, deviceToken: device.id!)
                return record.save(on: req)
            }
        }
    }
}

public enum InitializationError: Error {
    case environmentParameterMissing(String)
}

public enum CertificateError: Error {
    case passwordInvalid
    case environmentInvalid
    case unsupportedBundleIdentifier
}

public enum ShellError: Error {
    case commandNotFound
    case fileNotFound(String)
    case invalidExitCode(Int32)
    case unparseableData
}
