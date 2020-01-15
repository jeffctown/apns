import APNS
import Vapor

public final class DeviceController {
    
    public init() {}
    
    public func create(_ req: Request) throws -> Future<Device> {
        return try req.content.decode(Device.self).flatMap(to: Device.self) { device in
            return Device.query(on: req)
                .filter(\Device.id, .equal, device.id)
                .first()
                .flatMap { (existing) -> EventLoopFuture<Device> in
                if let existingDevice = existing {
                    existingDevice.type = device.type
                    existingDevice.environment = device.environment
                    existingDevice.bundleIdentifier = device.bundleIdentifier
                    existingDevice.pushType = device.pushType
                    return existingDevice.update(on: req)
                } else {
                    return device.save(on: req)
                }
            }
        }
    }
    
    public func read(_ req: Request) throws -> Future<Device> {
        return try req.parameters.next(Device.self)
    }
    
    public func index(_ req: Request) throws -> Future<[Device]> {
        return Device.query(on: req).all()
    }
    
    public func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Device.self).flatMap { device in
            return device.delete(on: req)
        }.transform(to: .ok)
    }
    
}
