//
//  Created by Emilio Peláez on 13/5/23.
//

import Model
import Monarch
import SwiftUI

struct StopsProvider: ViewModifier {
	@Environment(\.reportError) var reportError
	
	@State var stops: Transient<[Stop]> = .uninitialized
	
	func body(content: Content) -> some View {
		content
			.request { monarch in
				stops.start()
				try await stops.load {
					try await monarch.perform(StopsRequest())
						.stop
						.map(\.stop)
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
