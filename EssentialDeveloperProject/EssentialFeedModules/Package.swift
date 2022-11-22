// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "EssentialFeedModules",
    products: [
        .library(
            name: "EssentialFeedModules",
            targets: ["NetworkModule"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NetworkModule",
            dependencies: []),
        .testTarget(
            name: "NetworkModuleTests",
            dependencies: ["NetworkModule"]),
    ]
)
