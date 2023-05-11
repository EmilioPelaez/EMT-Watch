//
//  Created by Emilio Peláez on 10/5/23.
//

import HierarchyResponder
import Model
import SharedUI
import SwiftUI

struct BusStopScreen: View {
	@Environment(\.buses) var buses
	
	let stop: Stop
	
	var scrollable: Bool {
		switch buses {
		case .value(let buses) where !buses.isEmpty: return true
		case _: return false
		}
	}
	
	var body: some View {
		VStack {
			HStack {
				Image(systemName: "bus.fill")
				Text(stop.name)
					.extendHorizontally(alignment: .leading)
				EventButton(RefreshRequestedEvent()) {
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
			case .value(let buses) where !buses.isEmpty:
				BusListView(buses: buses)
			case _:
				MessageScreen(state: buses)
					.extendVertically()
			}
		}
		.scrollable(scrollable)
	}
}

struct BusStopScreen_Previews: PreviewProvider {
	static var previews: some View {
		BusStopScreen(stop: .example)
			.environment(\.buses, .value(.example))
		BusStopScreen(stop: .example)
			.environment(\.buses, .failure)
	}
}
