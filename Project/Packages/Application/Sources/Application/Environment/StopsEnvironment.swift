//
//  Created by Emilio Peláez on 11/5/23.
//

import Model
import SwiftUI

struct StopsKey: EnvironmentKey {
	static var defaultValue: DataState<[Stop]> = .uninitialized
}

extension EnvironmentValues {
	var stops: DataState<[Stop]> {
		get { self[StopsKey.self] }
		set { self[StopsKey.self] = newValue }
	}
}
