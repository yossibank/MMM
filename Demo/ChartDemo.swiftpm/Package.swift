// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import AppleProductTypes
import PackageDescription

let package = Package(
    name: "ChartDemo",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "ChartDemo",
            targets: ["ChartDemo"],
            bundleIdentifier: "yossibank-yahoo.co.jp.ChartDemo",
            teamIdentifier: "6WHPY5MQSB",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .heart),
            accentColor: .presetColor(.mint),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    dependencies: [
        .package(path: "../../Package")
    ],
    targets: [
        .executableTarget(
            name: "ChartDemo",
            dependencies: [
                .product(name: "Sample", package: "Package", condition: nil)
            ],
            path: "Sources"
        )
    ]
)