//
//  Created by Emilio Peláez on 10/5/23.
//

import HierarchyResponder
import Model
import Networking
import SharedUI
import SwiftUI

struct BusStopScreen: View {
	@Environment(\.triggerEvent) var triggerEvent
	@Environment(\.scenePhase) var scenePhase
	@Environment(\.buses) var buses
	
	let stop: Stop
	
	@State var lastRefresh: Date = .distantPast
	
	var scrollable: Bool {
		switch buses {
		case let .value(buses) where !buses.isEmpty: return true
		case _: return false
		}
	}
	
	var body: some View {
		VStack {
			HStack {
				Label(stop.name, systemImage: "bus.fill")
					.extendHorizontally(alignment: .leading)
				EventButton(RefreshEvent()) {
					Image(systemName: "arrow.counterclockwise")
						.symbolVariant(.circle)
						.font(.title3)
				}
				.buttonStyle(.plain)
			}
			.font(.caption2)
			.extendHorizontally(alignment: .leading)
			Divider()
			switch buses {
			case let .value(buses) where !buses.isEmpty:
				BusListView(buses: buses)
			case _:
				StateMessageView(state: buses)
					.extendVertically()
			}
		}
		.scrollable(scrollable)
		.navigationTitle("Buses")
		.navigationBarTitleDisplayMode(.inline)
		.onAppear { lastRefresh = .now }
		.onChange(of: scenePhase, equals: .active) { _ in
			guard Date.now.timeIntervalSince(lastRefresh) > 30 else { return }
			triggerEvent(RefreshEvent())
			lastRefresh = .now
		}
	}
}

struct BusStopScreen_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			BusStopScreen(stop: .example)
				.environment(\.buses, .value(.example))
		}
		NavigationStack {
			BusStopScreen(stop: .example)
				.environment(\.buses, .failure)
		}
	}
}
