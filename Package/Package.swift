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
        defaultLocalization: LanguageTag = "ja",
        platforms: [SupportedPlatform],
        dependencies: [Dependency] = [],
        targets: [Target],
        testTargets: [Target]
    ) -> Package {
        .init(
            name: name,
            defaultLocalization: defaultLocalization,
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

let billingStatementScreen = Target.target(
    name: "BillingStatementScreen"
)

let helpfulScreen = Target.target(
    name: "HelpfulScreen"
)

let otherScreen = Target.target(
    name: "OtherScreen"
)

let reportScreen = Target.target(
    name: "ReportScreen"
)

let sample = Target.target(
    name: "Sample",
    dependencies: [snapkit]
)

let spendingIncomeInputScreen = Target.target(
    name: "SpendingIncomeInputScreen"
)

let tabScreen = Target.target(
    name: "TabScreen",
    dependencies: [billingStatementScreen, helpfulScreen, otherScreen, reportScreen, spendingIncomeInputScreen],
    resources: [.process("Resources")]
)

let appIcon = Target.target(
    name: "AppIcon"
)

let appMock = Target.target(
    name: "AppMock",
    dependencies: [sample]
)

// MARK: - Test Package

let sampleTests = Target.testTarget(
    name: "SampleTests",
    dependencies: [appMock, sample]
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
            from: "0.54.2"
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            from: "5.7.1"
        )
    ],
    targets: [
        appIcon,
        appMock,
        billingStatementScreen,
        helpfulScreen,
        otherScreen,
        reportScreen,
        sample,
        spendingIncomeInputScreen,
        tabScreen
    ],
    testTargets: [
        sampleTests
    ]
)
