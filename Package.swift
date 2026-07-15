// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUI",
    platforms: [
            .iOS(.v18),
            .macOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CoreUI",
            targets: ["CoreUI"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.19.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CoreUI",
            path: "Sources"
        ),
        .testTarget(
            name: "CoreUITests",
            dependencies: [
                "CoreUI",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            path: "Tests"
        ),
    ]
)
