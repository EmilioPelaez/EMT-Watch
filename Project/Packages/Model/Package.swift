// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Model",
	platforms: [.watchOS(.v9), .iOS(.v16)],
	products: [
		.library(
			name: "Model",
			targets: ["Model"]
		),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "Model",
			dependencies: []
		),
		.testTarget(
			name: "ModelTests",
			dependencies: ["Model"]
		),
	]
)
