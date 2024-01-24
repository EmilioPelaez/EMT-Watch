//
//  Created by Emilio Peláez on 13/5/23.
//

import HierarchyResponder
import Model
import Monarch
import SwiftUI

struct BusesProvider: ViewModifier {
	@Environment(\.monarch) var monarch
	@Environment(\.reportError) var reportError
	
	let stop: Stop
	
	@State var buses: Transient<[Bus]> = .uninitialized
	
	func body(content: Content) -> some View {
		content
			.request { _ in try await update() }
			.handleEvent(RefreshEvent.self, handler: update)
			.environment(\.buses, buses)
	}
	
	func update() async throws {
		buses.start()
		try await buses.load {
			try await monarch.perform(BusesRequest(stopId: stop.id))
				.parada
				.bus
				.filter(\.isValid)
				.map(\.bus)
		}
	}
}

public extension View {
	func busesProvider(for stop: Stop) -> some View {
		modifier(BusesProvider(stop: stop))
	}
}
