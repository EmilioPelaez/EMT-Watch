//
//  Created by Emilio Peláez on 27/1/23.
//

import SwiftUI

struct SafeAreaInsetsKey: EnvironmentKey {
	static var defaultValue: EdgeInsets = .init()
}

public extension EnvironmentValues {
	var safeAreaInsets: EdgeInsets {
		get { self[SafeAreaInsetsKey.self] }
		set { self[SafeAreaInsetsKey.self] = newValue }
	}
}

public extension View {
	func readSafeArea() -> some View {
		modifier(SafeAreaReader())
	}
}

struct SafeAreaPreferenceKey: PreferenceKey {
	static var defaultValue: EdgeInsets = .init()
	
	static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {
		value = nextValue()
	}
}

struct SafeAreaReader: ViewModifier {
	@State private var safeAreaInsets: EdgeInsets = .init()
	
	func body(content: Content) -> some View {
		GeometryReader { reader in
			content
				.preference(key: SafeAreaPreferenceKey.self, value: reader.safeAreaInsets)
				.ignoresSafeArea()
		}
		.onPreferenceChange(SafeAreaPreferenceKey.self) { safeAreaInsets = $0 }
		.environment(\.safeAreaInsets, safeAreaInsets)
	}
}
