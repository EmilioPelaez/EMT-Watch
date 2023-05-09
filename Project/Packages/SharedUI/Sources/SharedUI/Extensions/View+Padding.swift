//
//  View+Padding.swift
//  UISupport
//
//  Created by Emilio Peláez on 7/2/22.
//

import SwiftUI

public extension View {
	
	func tinyPadding(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingTiny)
	}
	
	func smallPadding(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingSmall)
	}
	
	func mediumPadding(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingMedium)
	}
	
	func largePadding(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingLarge)
	}
	
	func exteaLargePadding(_ edges: Edge.Set = .all) -> some View {
		padding(edges, .paddingExtra)
	}
	
}
