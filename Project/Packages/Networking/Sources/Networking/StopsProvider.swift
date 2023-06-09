//
//  Created by Emilio Peláez on 13/5/23.
//

import Model
import Monarch
import SwiftUI

struct StopsProvider: ViewModifier {
	@Environment(\.reportError) var reportError
	
	@State var stops: DataState<[Stop]> = .uninitialized
	
	func body(content: Content) -> some View {
		content
			.request { monarch in
				stops = .loading
				do {
					let response = try await monarch.perform(StopsRequest())
					stops = .value(response.stop.map(\.stop))
				} catch {
					stops = .failure
					reportError(error)
				}
			}
			.environment(\.stops, stops)
	}
}

public extension View {
	func stopsProvider() -> some View {
		modifier(StopsProvider())
	}
}
