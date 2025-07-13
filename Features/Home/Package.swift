// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    defaultLocalization: "es",
    platforms: [.iOS("16.4")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"])
    ],
    dependencies: [
        .package(path: "../TestingUtilities"),
        .package(path: "../Common"),
        .package(path: "../Theme"),
        .package(path: "../LocalizedStrings"),
        .package(path: "../DataLayer"),
        .package(path: "../DomainLayer")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Home",
            dependencies: [
                "Common",
                "Theme",
                "LocalizedStrings",
                "DataLayer",
                "DomainLayer"
            ],
            resources: [],
            plugins: []
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: [
                "Home",
                "TestingUtilities"
            ]
        )
    ]
)
