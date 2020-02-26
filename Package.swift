// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "OSLog",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v10)
    ],
    products: [
        .library(name: "OSLog", targets: ["OSLog"])
    ],
    targets: [
        .target(name: "OSLog", path: "Source")
    ]
)

