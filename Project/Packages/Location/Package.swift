// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Location",
	platforms: [.iOS(.v16)],
	products: [
		.library(
			name: "Location",
			targets: ["Location"]
		),
	],
	dependencies: [
		.package(path: "../Shared"),
	],
	targets: [
		.target(
			name: "Location",
			dependencies: [
				"Shared",
			]
		),
		.testTarget(
			name: "LocationTests",
			dependencies: ["Location"]
		),
	]
)
