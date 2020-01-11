# APNS

![Platform](https://img.shields.io/badge/platforms-iOS%2013.0%20%7C%20macOS%2010.15%20%7C%20tvOS%2013.0%20%7C%20watchOS%206.0-blue.svg)

APNS is a simple Package to represent Apple Push Notification Service model objects.

| Build Status
| --------------| 
[![Travis CI](https://travis-ci.org/jeffctown/APNS.svg?branch=master)](https://travis-ci.org/jeffctown/APNS)

## Integration

#### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `APNS` by adding the proper description to your `Package.swift` file:

```swift
// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/jeffctown/APNS.git", from: "1.0.0"),
    ]
)
```

## Usage

#### Encoding APNS Payloads

```swift
let payload = PayloadBuilder { builder in
	builder.title = "APNS Title!"
	builder.body = "Something Exciting Just Happened!"
}.build()
let data = try JSONEncoder().encode(payload)
```

#### Decoding APNS Payloads

```swift 
let payloadString = """
                    {
                        "aps" : {
                            "category" : "NEW_MESSAGE_CATEGORY",
                            "alert" : {
                                "title" : "Game Request",
                                "body" : "Bob wants to play poker",
                                "action-loc-key" : "PLAY",
                            },
                            "content-available" : 1,
                            "badge" : 5,
                            "sound" : "bingbong.aiff",
                            "mutable-content": 1
                        }
                    }
                    """
let payloadData = payloadString.data(using: .utf8)!
let payload = try JSONDecoder().decode(Payload.self, from: payloadData)
```

