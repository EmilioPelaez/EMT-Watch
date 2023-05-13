//
//  Created by Emilio Peláez on 13/5/23.
//

import Model
import Monarch
import Networking
import SwiftUI

struct BusesProvider: ViewModifier {
	@Environment(\.reportError) var reportError
	
	let stop: Stop
	
	@State var buses: DataState<[Bus]> = .uninitialized
	
	func body(content: Content) -> some View {
		content
			.request { monarch in
				buses = .loading
				do {
					let response = try await monarch.perform(BusesRequest(stopId: stop.id))
					buses = .value([])
				} catch {
					buses = .failure
					reportError(error)
				}
			}
			.environment(\.buses, buses)
	}
}

extension View {
	func busesProvider(for stop: Stop) -> some View {
		modifier(BusesProvider(stop: stop))
	}
}

