//
//  Created by Emilio Peláez on 24/1/23.
//

import SwiftUI

struct TiltModifier: ViewModifier {
	let angle: Angle
	
	func body(content: Content) -> some View {
		content
			.rotation3DEffect(angle, axis: (1, 0, 0), anchor: .bottom)
	}
}

public enum TiltDirection {
	case forward
	case backwards
	
	fileprivate var angle: Angle {
		switch self {
		case .forward: return .degrees(-90)
		case .backwards: return .degrees(90)
		}
	}
}

public extension View {
	func tilted(_ direction: TiltDirection) -> some View {
		modifier(TiltModifier(angle: direction.angle))
	}
}

public extension AnyTransition {
	static func tilt(_ direction: TiltDirection = .backwards) -> AnyTransition {
		modifier(active: TiltModifier(angle: direction.angle),
		         identity: TiltModifier(angle: .zero))
	}
}
