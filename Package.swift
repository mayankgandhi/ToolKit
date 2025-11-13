// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Toolkit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .macCatalyst(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Toolkit",
            targets: ["Toolkit"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Toolkit",
            path: "Sources/Toolkit",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImportObjcForwardDeclarations"),
                .enableUpcomingFeature("DisableOutwardActorInference"),
                .enableUpcomingFeature("InternalImportsByDefault"),
                .enableUpcomingFeature("IsolatedDefaultValues"),
                .enableUpcomingFeature("GlobalConcurrency"),
            ]
        ),
        .testTarget(
            name: "ToolkitTests",
            dependencies: ["Toolkit"],
            path: "Tests/ToolkitTests"
        ),
    ]
)
