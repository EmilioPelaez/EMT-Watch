// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Networking",
	platforms: [.watchOS(.v9), .iOS(.v16)],
	products: [
		.library(
			name: "Networking",
			targets: ["Networking"]),
	],
	dependencies: [
		.package(path: "../Shared"),
	],
	targets: [
		.target(
			name: "Networking",
			dependencies: [
				"Shared",
			]),
		.testTarget(
			name: "NetworkingTests",
			dependencies: ["Networking"]),
	]
)
