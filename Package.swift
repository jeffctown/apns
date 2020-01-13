// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APNS",
    products: [
        .library(name: "APNS", targets: ["APNS"]),
        .library(name: "APNSFluent", targets: ["APNSFluent"]),
        .library(name: "APNSVapor", targets: ["APNSVapor"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "3.0.0")),
        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", .upToNextMajor(from: "3.0.0")),
    ],
    targets: [
        .target(name: "APNS"),
        .testTarget(name: "APNSTests", dependencies: ["APNS"]),
        .target(name: "APNSFluent", dependencies: ["APNS", "FluentSQLite"]),
        .testTarget(name: "APNSFluentTests", dependencies: ["APNSFluent"]),
        .target(name: "APNSVapor", dependencies: ["APNS","APNSFluent","Vapor"]),
        .testTarget(name: "APNSVaporTests", dependencies: ["APNSVapor"]),
    ]
)
