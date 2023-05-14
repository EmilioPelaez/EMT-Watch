//
//  Created by Emilio Peláez on 11/5/23.
//

import SwiftUI

struct StopsKey: EnvironmentKey {
	static var defaultValue: DataState<[Stop]> = .uninitialized
}

extension EnvironmentValues {
	public var stops: DataState<[Stop]> {
		get { self[StopsKey.self] }
		set { self[StopsKey.self] = newValue }
	}
}
