// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Shared",
	platforms: [.watchOS(.v9), .iOS(.v16)],
	products: [
		.library(
			name: "Shared",
			targets: ["Shared"]),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "Shared",
			dependencies: []),
		.testTarget(
			name: "SharedTests",
			dependencies: ["Shared"]),
	]
)
