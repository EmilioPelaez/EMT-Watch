//
//  ActionButtonStyle.swift
//  UISupport
//
//  Created by Emilio Peláez on 7/2/22.
//

import SwiftUI

public struct ActionButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) private var isEnabled
	
	let color: Color
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.headline)
			.foregroundColor(.white)
			.opacity(configuration.isPressed ? 0.75 : 1)
			.padding(.paddingMedium)
			.padding(.horizontal, .paddingLarge)
			.background {
				color
					.brightness(configuration.isPressed ? -0.25 : 0)
			}
			.cornerRadius(.paddingMedium)
			.visiblyDisabled(!isEnabled)
	}
}

public extension ButtonStyle where Self == ActionButtonStyle {
	static func action(_ color: Color) -> ActionButtonStyle {
		ActionButtonStyle(color: color)
	}
}
