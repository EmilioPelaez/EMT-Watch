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
	
	@State var buses: DataState<[Bus]> = .uninitialized
	
	func body(content: Content) -> some View {
		content
			.onAppear(perform: update)
			.handleEvent(RefreshEvent.self, handler: update)
			.environment(\.buses, buses)
	}
	
	func update() {
		Task {
			buses = .loading
			do {
				let response = try await monarch.perform(BusesRequest(stopId: stop.id))
				buses = .value(response.parada.bus.map(\.bus))
			} catch {
				buses = .failure
				reportError(error)
			}
		}
	}
}

public extension View {
	func busesProvider(for stop: Stop) -> some View {
		modifier(BusesProvider(stop: stop))
	}
}

