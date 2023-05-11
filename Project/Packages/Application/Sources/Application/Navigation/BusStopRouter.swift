//
//  Created by Emilio Peláez on 10/5/23.
//

import HierarchyResponder
import SwiftUI

struct BusStopRouter: View {
	@State var route: [BusStopStep] = []
	
	var body: some View {
		NavigationStack(path: $route) {
			StopListView()
				.navigationDestination(for: BusStopStep.self) { step in
					switch step {
					case .station(let station):
						BusStopView(stopName: station, buses: .example)
					}
				}
		}
		.handleEvent(StationSelectedEvent.self) { route.append(.station($0.station)) }
	}
}

enum BusStopStep: Hashable {
	case station(String)
}

struct BusStopRouter_Previews: PreviewProvider {
	static var previews: some View {
		BusStopRouter()
	}
}
