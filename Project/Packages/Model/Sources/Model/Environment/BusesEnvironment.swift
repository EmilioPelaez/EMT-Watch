//
//  Created by Emilio Peláez on 11/5/23.
//

import SwiftUI

struct BusesKey: EnvironmentKey {
	static var defaultValue: DataState<[Bus]> = .uninitialized
}

extension EnvironmentValues {
	public var buses: DataState<[Bus]> {
		get { self[BusesKey.self] }
		set { self[BusesKey.self] = newValue }
	}
}
