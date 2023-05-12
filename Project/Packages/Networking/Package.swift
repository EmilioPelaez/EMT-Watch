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
		.package(path: "../Model"),
		.package(url: "https://github.com/EmilioPelaez/HierarchyResponder", from: .init(1, 0, 0)),
		.package(url: "https://github.com/EmilioPelaez/Monarch", branch: "main"),
	],
	targets: [
		.target(
			name: "Networking",
			dependencies: [
				"Shared",
				"Model",
				"HierarchyResponder",
				"Monarch",
			]),
		.testTarget(
			name: "NetworkingTests",
			dependencies: ["Networking"]),
	]
)
