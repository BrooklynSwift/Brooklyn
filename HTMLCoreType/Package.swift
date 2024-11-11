// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
	name: "HTMLCoreType",
	platforms: [.macOS(.v13)],
	products: [.library(name: "HTMLCoreType", targets: ["HTMLCoreType"])],
	dependencies: [.package(url: "https://github.com/apple/swift-syntax", from: "509.0.0")],
	targets: [
		.macro(
			name: "HTMLCoreTypeMacros",
			dependencies: [
				.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
				.product(name: "SwiftCompilerPlugin", package: "swift-syntax")
			]
		),
		.target(name: "HTMLCoreType", dependencies: ["HTMLCoreTypeMacros"])
	]
)
