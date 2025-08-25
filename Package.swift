// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Brooklyn",
	platforms: [.macOS(.v13)],
	products: [
		.library(name: "Brooklyn", targets: ["Brooklyn"]),
		.executable(name: "BrooklynCLI", targets: ["BrooklynCLI"])
	],
	dependencies: [
		.package(url: "https://github.com/BrooklynSwift/HTMLCoreType", branch: "main"),
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0")
	],
	targets: [
		.target(
			name: "Brooklyn",
			dependencies: [.product(name: "HTMLCoreType", package: "HTMLCoreType")]
		),
		.executableTarget(
			name: "BrooklynCLI",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]
		)
	]
)
