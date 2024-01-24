//
//  Created by Emilio Peláez on 11/5/23.
//

import SwiftUI

struct StopsKey: EnvironmentKey {
	static var defaultValue: Transient<[Stop]> = .uninitialized
}

public extension EnvironmentValues {
	var stops: Transient<[Stop]> {
		get { self[StopsKey.self] }
		set { self[StopsKey.self] = newValue }
	}
}
