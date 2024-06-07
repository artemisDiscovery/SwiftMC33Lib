// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

// wrapper around code by David Vega & Javier Abache
// https://github.com/dvega68/MC33_c_library

import PackageDescription

let package = Package(
    name: "SwiftMC33Lib",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftMC33Lib",
            targets: ["SwiftMC33Lib"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftMC33Lib",
            exclude: ["marching_cubes_33.c"]
            ),
        .testTarget(
            name: "SwiftMC33LibTests",
            dependencies: ["SwiftMC33Lib"]),
    ]
)
