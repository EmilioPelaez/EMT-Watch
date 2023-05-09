//
//  View+Preview.swift
//  UISupport
//
//  Created by Emilio Peláez on 13/02/22.
//

import SwiftUI

public extension View {
	
	func preparePreview() -> some View {
		padding()
//			.background(Color.secondarySystemBackground)
			.previewLayout(.sizeThatFits)
	}
	
	@ViewBuilder
	func previewColorSchemes() -> some View {
		VStack {
			colorScheme(.light)
			colorScheme(.dark)
		}
	}
	
	@ViewBuilder
	func previewFontSizes(showAccessibility: Bool = false) -> some View {
		VStack {
			if #available(iOS 15.0, *) {
				environment(\.dynamicTypeSize, .xSmall)
				environment(\.dynamicTypeSize, .medium)
				environment(\.dynamicTypeSize, .xxxLarge)
				if showAccessibility {
					environment(\.dynamicTypeSize, .accessibility5)
				}
			} else {
				self
			}
		}
	}
	
}
