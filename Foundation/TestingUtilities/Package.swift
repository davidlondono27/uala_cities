// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestingUtilities",
    defaultLocalization: "es",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TestingUtilities",
            targets: ["TestingUtilities"])
    ],
    dependencies: [
        .package(url: "https://github.com/ashfurrow/Nimble-Snapshots", exact: "9.8.0"),
        .package(url: "https://github.com/Quick/Quick.git", from: "7.6.2"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.55.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TestingUtilities",
            dependencies: [
                "Nimble-Snapshots",
                "Quick"
            ],
            resources: [],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        .testTarget(
            name: "TestingUtilitiesTests",
            dependencies: ["TestingUtilities"])
    ]
)
