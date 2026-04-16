// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesSPM",

    platforms: [
        .iOS(.v17)
    ],

    products: [
        .library(
            name: "MoviesSPM",
            targets: ["MoviesSPM"]
        ),
    ],

    dependencies: [
        .package(path: "../NetworkLayerSPM")
    ],

    targets: [
        .target(
            name: "MoviesSPM",
            dependencies: [
                .product(name: "NetworkLayerSPM", package: "NetworkLayerSPM")
            ]
        ),

        .testTarget(
            name: "MoviesSPMTests",
            dependencies: ["MoviesSPM"]
        )
    ],

    swiftLanguageModes: [.v6]
)

