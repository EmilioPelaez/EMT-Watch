//
//  Created by Emilio Peláez on 13/5/23.
//

import Model
import Monarch
import Networking
import SwiftUI

struct StopsProvider: ViewModifier {
	@State var stops: DataState<[Stop]> = .uninitialized
	
	func body(content: Content) -> some View {
		content
			.request { monarch in
				stops = .loading
				do {
					let response = try await monarch.perform(StopsRequest())
					stops = .value([])
				} catch {
					stops = .failure
				}
			}
			.environment(\.stops, stops)
	}
}

extension View {
	func stopsProvider() -> some View {
		modifier(StopsProvider())
	}
}
