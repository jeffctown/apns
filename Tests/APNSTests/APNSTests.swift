import XCTest
@testable import APNS

final class APNSTests: XCTestCase {
    
    static let testPayload = "TestPayload"
    
    func testPayloadDecoding() {
        let testResource = try! Resource(name: APNSTests.testPayload, type: "json")
        let testData = try! Data(contentsOf: testResource.url)
        let decoder = JSONDecoder()
        let testPayload = try! decoder.decode(Payload.self, from: testData)
        XCTAssert(testPayload.aps.alert.body == "Bob wants to play poker")
        XCTAssert(testPayload.aps.alert.title == "Game Request")
        XCTAssert(testPayload.aps.alert.actionLocKey == "PLAY")
        XCTAssert(testPayload.aps.contentAvailable == 1)
        XCTAssert(testPayload.aps.hasMutableContent == 1)
        XCTAssert(testPayload.aps.badge == 5)
        XCTAssert(testPayload.aps.sound == "bingbong.aiff")
        XCTAssert(testPayload.aps.category == "NEW_MESSAGE_CATEGORY")
    }
    
    func testPayloadEncoding() throws {
        
        let expectedPayload = """
        {"aps":{"alert":{"title":"Game Request","body":"Bob wants to play poker"},"mutable-content":0,"content-available":0},"extra":{}}
        """
        let payload = PayloadBuilder { builder in
            builder.title = "Game Request"
            builder.body = "Bob wants to play poker"
        }.build()
        let payloadData = try JSONEncoder().encode(payload)
        let payloadString = String(data: payloadData, encoding: .utf8)
        XCTAssertEqual(payloadString, expectedPayload)
    }

    static var allTests = [
        ("testPayloadDecoding", testPayloadDecoding), ("testPayloadEncoding", testPayloadEncoding)
    ]
}

struct Resource {
  let name: String
  let type: String
  let url: URL

  init(name: String, type: String, sourceFile: StaticString = #file) throws {
    self.name = name
    self.type = type

    // The following assumes that your test source files are all in the same directory, and the resources are one directory down and over
    // <Some folder>
    //  - Resources
    //      - <resource files>
    //  - <Some test source folder>
    //      - <test case files>
    let testCaseURL = URL(fileURLWithPath: "\(sourceFile)", isDirectory: false)
    let testsFolderURL = testCaseURL.deletingLastPathComponent()
    let resourcesFolderURL = testsFolderURL.deletingLastPathComponent().appendingPathComponent("Resources", isDirectory: true)
    self.url = resourcesFolderURL.appendingPathComponent("\(name).\(type)", isDirectory: false)
  }
}
