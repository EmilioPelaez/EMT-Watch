// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SharedUI",
	platforms: [.watchOS(.v9)],
	products: [
		.library(
			name: "SharedUI",
			targets: ["SharedUI"]),
	],
	dependencies: [
		.package(path: "../Shared"),
		.package(url: "https://github.com/EmilioPelaez/CGMath", from: .init(1, 0, 0)),
		.package(url: "https://github.com/EmilioPelaez/HierarchyResponder", from: .init(1, 0, 0)),
	],
	targets: [
		.target(
			name: "SharedUI",
			dependencies: [
			"Shared",
			"CGMath",
			"HierarchyResponder",
			]),
		.testTarget(
			name: "SharedUITests",
			dependencies: ["SharedUI"]),
	]
)
