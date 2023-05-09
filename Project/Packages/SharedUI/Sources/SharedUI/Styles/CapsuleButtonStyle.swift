//
//  Created by Emilio Peláez on 18/12/22.
//

import SwiftUI

public struct CapsuleButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) private var isEnabled
	
	let color: Color
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.foregroundColor(.white)
			.opacity(configuration.isPressed ? 0.75 : 1)
			.font(.headline)
			.mediumPadding()
			.largePadding(.horizontal)
			.background {
				Capsule()
					.foregroundColor(color)
					.brightness(configuration.isPressed ? -0.25 : 0)
			}
			.contentShape(Capsule())
			.visiblyDisabled(!isEnabled)
	}
}

public extension ButtonStyle where Self == CapsuleButtonStyle {
	static func capsule(_ color: Color) -> CapsuleButtonStyle {
		CapsuleButtonStyle(color: color)
	}
}
