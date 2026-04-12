// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkLayer-SPM",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkLayer-SPM",
            targets: ["NetworkLayer-SPM"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkLayer-SPM"
        ),
        .testTarget(
            name: "NetworkLayer-SPMTests",
            dependencies: ["NetworkLayer-SPM"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
