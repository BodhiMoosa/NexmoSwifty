// swift-tools-version:5.3
// v0.1.0

// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NexmoSwifty",
    platforms: [
        .macOS(.v10_15)
    ], products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NexmoSwifty",
            targets: ["NexmoSwifty"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0")

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NexmoSwifty",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWTKit", package: "jwt-kit")
            ]),
        .testTarget(
            name: "NexmoSwiftyTests",
            dependencies: ["NexmoSwifty"]),
    ]
)
