// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "fof_tca",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "fof_tca",
            targets: ["AppEngine"]
        ),
        .executable(
            name: "AppCLI",
            targets: [
                "CLI"
            ]),
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: []
        ),
        .target(
            name: "AppEngine",
            dependencies: ["AppCore"]
        ),
        .executableTarget(
            name: "CLI",
            dependencies: ["AppEngine"]
        ),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]
        ),
        .testTarget(
            name: "AppEngineTests",
            dependencies: ["AppEngine"]
        ),
    ]
)
