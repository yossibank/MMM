// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BuildTools",
    dependencies: [
        .package(
            url: "https://github.com/nicklockwood/SwiftFormat",
            from: "0.54.3"
        ),
        .package(
            url: "https://github.com/mono0926/LicensePlist",
            from: "3.25.1"
        )
    ],
    targets: [
        .target(
            name: "BuildTools",
            path: ""
        )
    ]
)
