//
//  Created by Emilio Peláez on 11/5/23.
//

import SwiftUI

struct FavoritesKey: EnvironmentKey {
	static var defaultValue: [String] = []
}

public extension EnvironmentValues {
	var favorites: [String] {
		get { self[FavoritesKey.self] }
		set { self[FavoritesKey.self] = newValue }
	}
}
