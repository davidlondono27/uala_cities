// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "uala_citiesUI",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "uala_citiesUI",
            targets: ["uala_citiesUI"])
    ],
    dependencies: [
        .package(path: "../TestingUtilities")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "uala_citiesUI",
            dependencies: [],
            plugins: []
        ),
        .testTarget(
            name: "uala_citiesUITests",
            dependencies: [
                "uala_citiesUI",
                "TestingUtilities"
            ]
        )
    ]
)
