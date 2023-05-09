// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Application",
	platforms: [.watchOS(.v9)],
	products: [
		.library(
			name: "Application",
			targets: ["Application"]),
	],
	dependencies: [
		.package(path: "../Networking"),
	],
	targets: [
		.target(
			name: "Application",
			dependencies: [
				"Networking",
			]),
		.testTarget(
			name: "ApplicationTests",
			dependencies: ["Application"]),
	]
)
