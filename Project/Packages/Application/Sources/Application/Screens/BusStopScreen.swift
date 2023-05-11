//
//  Created by Emilio Peláez on 10/5/23.
//

import HierarchyResponder
import Model
import SharedUI
import SwiftUI

struct BusStopScreen: View {
	let stopName: String
	let buses: [Bus]
	
	var body: some View {
		VStack {
			HStack {
				Image(systemName: "bus.fill")
				Text(stopName)
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
			if buses.isEmpty {
				EmptyBusesView()
					.extendVertically()
			} else {
				BusListView(buses: buses)
			}
		}
		.scrollable(!buses.isEmpty)
	}
}

struct BusStopScreen_Previews: PreviewProvider {
	static var previews: some View {
		BusStopScreen(stopName: "729", buses: .example)
		BusStopScreen(stopName: "729", buses: [])
	}
}