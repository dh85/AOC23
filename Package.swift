// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AOC23",
  platforms: [ .macOS(.v13) ],
  targets: [
    .executableTarget(name: "AOC23", resources: [.process("Inputs")]),
    .testTarget(name: "AOC23Tests", dependencies: ["AOC23"])
  ]
)

let swiftSettings: [SwiftSetting] = [
  // -enable-bare-slash-regex becomes
  .enableUpcomingFeature("BareSlashRegexLiterals"),
]

for target in package.targets {
  target.swiftSettings = target.swiftSettings ?? []
  target.swiftSettings?.append(contentsOf: swiftSettings)
}
