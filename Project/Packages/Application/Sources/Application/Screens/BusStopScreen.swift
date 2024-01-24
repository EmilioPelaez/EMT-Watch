//
//  Created by Emilio Peláez on 10/5/23.
//

import HierarchyResponder
import Model
import Networking
import Shared
import SharedUI
import SwiftUI

struct BusStopScreen: View {
	@Environment(\.triggerEvent) var triggerEvent
	@Environment(\.scenePhase) var scenePhase
	@Environment(\.buses) var busesData
	
	let stop: Stop
	
	@State var lastRefresh: Date = .distantPast
	
	var buses: [Bus] {
		switch busesData {
		case .value(let lines), .reloading(let lines): lines
		case .failure(let lines, _): lines ?? []
		case _: []
		}
	}
	
	var body: some View {
		VStack {
			HStack {
				Label(stop.name, systemImage: "bus.fill")
					.extendHorizontally(alignment: .leading)
				ZStack {
					ProgressView()
						.opacity(busesData.isLoading ? 1 : 0)
					EventButton(RefreshEvent()) {
						Image(systemName: "arrow.counterclockwise")
							.symbolVariant(.circle)
							.font(.title3)
					}
					.opacity(busesData.isLoading ? 0 : 1)
				}
				.fixedSize()
				.buttonStyle(.plain)
			}
			.font(.caption2)
			.extendHorizontally(alignment: .leading)
			Divider()
			if let buses = buses.notEmptyOrNil {
				BusListView(buses: buses)
			} else {
				StateMessageView(state: busesData)
					.extendVertically()
			}
		}
		.scrollable(!buses.isEmpty)
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
				.environment(\.buses, .failure(nil, DummyError()))
		}
	}
}
