public final class Device: Codable, Equatable {
    
    public static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.id == rhs.id && lhs.type == rhs.type && lhs.token == rhs.token && lhs.environment
            == rhs.environment
    }
    
    public var id: Int?
    public var type: String
    public var token: String
    public var environment: APNS.Environment
    
    public init(type: String, token: String, environment: APNS.Environment = .sandbox) {
        self.type = type
        self.token = token
        self.environment = environment
    }
}
