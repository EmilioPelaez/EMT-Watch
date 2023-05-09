//
//  Created by Emilio Peláez on 21/1/23.
//

import SwiftUI

struct ScreenActiveKey: EnvironmentKey {
	static var defaultValue = true
}

public extension EnvironmentValues {
	var isScreenActive: Bool {
		get { self[ScreenActiveKey.self] }
		set { self[ScreenActiveKey.self] = newValue }
	}
}

public extension View {
	func isScreenActive(_ active: Bool) -> some View {
		environment(\.isScreenActive, active)
	}
}
