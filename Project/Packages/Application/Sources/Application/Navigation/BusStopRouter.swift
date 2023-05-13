//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import HierarchyResponder
import SwiftUI

struct BusStopRouter: View {
	@State var route: [BusStopStep] = []
	
	var body: some View {
		NavigationStack(path: $route) {
			StopListScreen()
				.stopsProvider()
				.navigationDestination(for: BusStopStep.self) { step in
					switch step {
					case .schedule(let stop):
						BusStopScreen(stop: stop)
							.busesProvider(for: stop)
					case .info(let stop):
						StopInfoScreen(stop: stop)
					}
				}
		}
		.handleEvent(StopSelectedEvent.self) { route.append(.schedule($0.stop)) }
		.handleEvent(StopInfoEvent.self) { route.append(.info($0.stop)) }
	}
}

enum BusStopStep: Hashable {
	case schedule(Stop)
	case info(Stop)
}

struct BusStopRouter_Previews: PreviewProvider {
	static var previews: some View {
		BusStopRouter()
			.environment(\.stops, .value(.example))
	}
}
