//
//  Created by Emilio Peláez on 10/5/23.
//

import HierarchyResponder
import SwiftUI

struct BusStopRouter: View {
	@State var route: [BusStopStep] = []
	
	var body: some View {
		NavigationStack(path: $route) {
			StopListScreen()
				.navigationDestination(for: BusStopStep.self) { step in
					switch step {
					case .schedule(let stop):
						BusStopScreen(stopName: stop, buses: .example)
					case .info(let stop):
						StopInfoScreen(stop: .example)
					}
				}
		}
		.handleEvent(StationSelectedEvent.self) { route.append(.schedule($0.station)) }
	}
}

enum BusStopStep: Hashable {
	case schedule(String)
	case info(String)
}

struct BusStopRouter_Previews: PreviewProvider {
	static var previews: some View {
		BusStopRouter()
	}
}
