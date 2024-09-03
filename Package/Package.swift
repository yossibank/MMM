// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Library

let introspect = Target.Dependency.product(
    name: "SwiftUIIntrospect",
    package: "swiftui-introspect"
)

// MARK: - Package

let appDebug = Target.target(
    name: "AppDebug"
)

let appIcon = Target.target(
    name: "AppIcon"
)

let utility = Target.target(
    name: "Utility"
)

let mmmData = Target.target(
    name: "MMMData"
)

let mmmFoundation = Target.target(
    name: "MMMFoundation",
    dependencies: [
        utility
    ]
)

let mmmView = Target.target(
    name: "MMMView",
    dependencies: [
        mmmData,
        mmmFoundation
    ]
)

let utilityView = Target.target(
    name: "UtilityView",
    dependencies: [
        mmmData
    ]
)

let inputView = Target.target(
    name: "InputView",
    dependencies: [
        mmmFoundation,
        mmmView,
        utilityView
    ],
    dependenciesLibraries: [
        introspect
    ]
)

let listView = Target.target(
    name: "ListView",
    dependencies: [
        utilityView
    ]
)

let otherView = Target.target(
    name: "OtherView",
    dependencies: [
        mmmData,
        mmmView,
        utilityView
    ]
)

let reportView = Target.target(
    name: "ReportView",
    dependencies: [
        utilityView
    ]
)

let mmmTab = Target.target(
    name: "MMMTab",
    dependencies: [
        mmmData,
        utilityView,
        inputView,
        listView,
        otherView,
        reportView
    ]
)

// MARK: - Test Package

let mmmFoundationTests = Target.testTarget(
    name: "MMMFoundationTests",
    dependencies: [mmmFoundation]
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
            from: "0.54.3"
        ),
        .package(
            url: "https://github.com/siteline/swiftui-introspect",
            from: "1.3.0"
        )
    ],
    targets: [
        appDebug,
        appIcon,
        inputView,
        listView,
        mmmData,
        mmmFoundation,
        mmmTab,
        mmmView,
        otherView,
        reportView,
        utility,
        utilityView
    ],
    testTargets: [
        mmmFoundationTests
    ]
)

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
        resources: [Resource] = [],
        swiftSettings: [SwiftSetting] = SwiftSetting.allCases
    ) -> Target {
        .target(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            resources: resources,
            swiftSettings: swiftSettings
        )
    }

    static func testTarget(
        name: String,
        dependencies: [Target],
        dependenciesLibraries: [Target.Dependency] = [],
        resources: [Resource] = [],
        swiftSettings: [SwiftSetting] = SwiftSetting.allCases
    ) -> Target {
        .testTarget(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            resources: resources,
            swiftSettings: swiftSettings
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

// MARK: - Swift Upcoming Feature Flags

extension SwiftSetting {
    /// Forward-scan matching for trailing closures
    /// - Version: Swift 5.3
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0286-forward-scan-trailing-closures.md
    static let forwardTrailingClosures: Self = .enableUpcomingFeature("ForwardTrailingClosures")
    /// Introduce existential `any`
    /// - Version: Swift 5.6
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md
    static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny")
    /// Regex Literals
    /// - Version: Swift 5.7
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md
    static let bareSlashRegexLiterals: Self = .enableUpcomingFeature("BareSlashRegexLiterals")
    /// Concise magic file names
    /// - Version: Swift 5.8
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0274-magic-file.md
    static let conciseMagicFile: Self = .enableUpcomingFeature("ConciseMagicFile")
    /// Importing Forward Declared Objective-C Interfaces and Protocols
    /// - Version: Swift 5.9
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0384-importing-forward-declared-objc-interfaces-and-protocols.md
    static let importObjcForwardDeclarations: Self = .enableUpcomingFeature("ImportObjcForwardDeclarations")
    /// Remove Actor Isolation Inference caused by Property Wrappers
    /// - Version: Swift 5.9
    /// https://github.com/apple/swift-evolution/blob/main/proposals/0401-remove-property-wrapper-isolation.md
    static let disableOutwardActorInference: Self = .enableUpcomingFeature("DisableOutwardActorInference")
    /// Deprecate `@UIApplicationMain` and `@NSApplicationMain`
    /// - Version: Swift 5.10
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0383-deprecate-uiapplicationmain-and-nsapplicationmain.md
    static let deprecateApplicationMain: Self = .enableUpcomingFeature("DeprecateApplicationMain")
    /// Isolated default value expressions
    /// - Version: Swift 5.10
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0411-isolated-default-values.md
    static let isolatedDefaultValues: Self = .enableUpcomingFeature("IsolatedDefaultValues")
    /// Strict concurrency for global variables
    /// - Version: Swift 5.10
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0412-strict-concurrency-for-global-variables.md
    static let globalConcurrency: Self = .enableUpcomingFeature("GlobalConcurrency")
}

extension SwiftSetting: CaseIterable {
    public static var allCases: [Self] {
        [
            .forwardTrailingClosures,
            .existentialAny,
            .bareSlashRegexLiterals,
            .conciseMagicFile,
            .importObjcForwardDeclarations,
            .disableOutwardActorInference,
            .deprecateApplicationMain,
            .isolatedDefaultValues,
            .globalConcurrency
        ]
    }
}
