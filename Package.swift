// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TSKit",
    platforms: [.iOS(.v9)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "TSKit.Core", targets: ["TSKit.Core"]),
        .library(name: "TSKit.Log", targets: ["TSKit.Log"]),
        .library(name: "TSKit.Storage", targets: ["TSKit.Storage"]),
        .library(name: "TSKit.UI", targets: ["TSKit.UI"]),
        .library(name: "TSKit.Validation", targets: ["TSKit.Validation"]),
        .library(name: "TSKit.Networking", targets: ["TSKit.Networking"]),
        .library(name: "TSKit.Networking.Alamofire", targets: ["TSKit.Networking", "TSKit.Networking.Alamofire"]),
        .library(name: "TSKit.Stomp", targets: ["TSKit.Stomp"]),
        .library(name: "TSKit.Injection", targets: ["TSKit.Injection"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/daltoniam/Starscream.git", .upToNextMajor(from: "4.0.0")),
    ],
    targets: [
        .target(name: "TSKit.Core", dependencies: ["TSKit.Core.ObjC"]),
        .target(name: "TSKit.Core.ObjC", dependencies: []),
       
        .target(name: "TSKit.Log", dependencies: ["TSKit.Core"]),
        .target(name: "TSKit.Storage", dependencies: ["TSKit.Core"]),
       
        .target(name: "TSKit.UI", dependencies: ["TSKit.Core"], exclude: ["WIP"]),
       
        .target(name: "TSKit.System", dependencies: ["TSKit.Core"]),
        .target(name: "TSKit.Injection", dependencies: ["TSKit.Core", "TSKit.Log"]),
       
        .target(name: "TSKit.Validation", dependencies: ["TSKit.Core"]),
       
        .target(name: "TSKit.Networking", dependencies: ["TSKit.Core"]),
        .target(name: "TSKit.Networking.Alamofire", dependencies: ["TSKit.Networking", "Alamofire", "TSKit.Core", "TSKit.Log", "TSKit.Injection"]),
        
        .target(name: "TSKit.Stomp", dependencies: ["TSKit.Core", "Starscream"]),
        
        
        .testTarget(name: "TSKit.Core.Tests", dependencies: ["TSKit.Core"]),
        .testTarget(name: "TSKit.Storage.Tests", dependencies: ["TSKit.Storage"]),
        .testTarget(name: "TSKit.Log.Tests", dependencies: ["TSKit.Log"]),
        .testTarget(name: "TSKit.Stomp.Tests", dependencies: ["TSKit.Stomp"]),
    ],
    swiftLanguageVersions: [.version("5.3")]
)
