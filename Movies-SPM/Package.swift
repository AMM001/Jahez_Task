// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Movies-SPM",
    
    products: [
        .library(
            name: "Movies-SPM",
            targets: ["Movies-SPM"]
        ),
    ],
    
    dependencies: [
        .package(path: "../NetworkLayer-SPM") // 👈 LOCAL PACKAGE
    ],
    
    targets: [
        .target(
            name: "Movies-SPM",
            dependencies: [
                .product(name: "NetworkLayer-SPM", package: "NetworkLayer-SPM")
            ]
        ),
        
        .testTarget(
            name: "Movies-SPMTests",
            dependencies: ["Movies-SPM"]
        ),
    ],
    
    swiftLanguageModes: [.v6]
)
