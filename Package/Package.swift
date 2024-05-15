// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Extension

extension Target {
    private var dependency: Target.Dependency {
        .target(
            name: name,
            condition: nil
        )
    }

    fileprivate func library(targets: [Target] = []) -> Product {
        .library(
            name: name,
            targets: [name] + targets.map(\.name)
        )
    }

    static func target(
        name: String,
        dependencies: [Target] = [],
        dependenciesLibraries: [Target.Dependency] = [],
        resources: [Resource] = []
    ) -> Target {
        .target(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            resources: resources
        )
    }

    static func testTarget(
        name: String,
        dependencies: [Target],
        dependenciesLibraries: [Target.Dependency] = [],
        resources: [Resource] = []
    ) -> Target {
        .testTarget(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            resources: resources
        )
    }
}

extension Package {
    static func package(
        name: String,
        platforms: [SupportedPlatform],
        dependencies: [Dependency] = [],
        targets: [Target],
        testTargets: [Target]
    ) -> Package {
        .init(
            name: name,
            platforms: platforms,
            products: targets.map { $0.library() },
            dependencies: dependencies,
            targets: targets + testTargets
        )
    }
}

// MARK: - Library

let snapkit = Target.Dependency.product(
    name: "SnapKit",
    package: "SnapKit"
)

// MARK: - Package

let appIcon = Target.target(
    name: "AppIcon"
)

let sample = Target.target(
    name: "Sample",
    dependencies: [snapkit]
)

let mock = Target.target(
    name: "Mock",
    dependencies: [sample]
)

// MARK: - Test Package

let sampleTests = Target.testTarget(
    name: "SampleTests",
    dependencies: [sample, mock]
)

// MARK: - Target

let package = Package.package(
    name: "Package",
    platforms: [
        .iOS(.v17)
    ],
    dependencies: [
        .package(
            url: "https://github.com/nicklockwood/SwiftFormat",
            from: "0.53.9"
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            from: "5.7.1"
        )
    ],
    targets: [
        appIcon,
        sample,
        mock
    ],
    testTargets: [
        sampleTests
    ]
)
