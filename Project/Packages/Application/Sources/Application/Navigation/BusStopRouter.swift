//
//  Created by Emilio Peláez on 10/5/23.
//

import Location
import Model
import Monarch
import Networking
import HierarchyResponder
import SwiftUI

struct BusStopRouter: View {
	@State var route: [BusStopStep] = []
	
	var isSimulator: Bool {
#if targetEnvironment(simulator)
	true
#else
	false
#endif
	}
	
	var body: some View {
		NavigationStack(path: $route) {
			StopListScreen()
				.navigationDestination(for: BusStopStep.self) { step in
					switch step {
					case .schedule(let stop):
						BusStopScreen(stop: stop)
							.busesProvider(for: stop)
					case .info(let stop):
						StopInfoScreen(stop: stop)
					case .search:
						SearchScreen()
					}
				}
		}
		.favoritesProvider()
		.stopsProvider()
		.if(isSimulator) {
			$0.locationDemoProvider(.init(latitude: 39.470022, longitude: -0.376823))
		} else: {
			$0.locationProvider()
		}
		.registerProvider(EMTClient())
		.handleEvent(StopSelectedEvent.self) { route.append(.schedule($0.stop)) }
		.handleEvent(StopInfoEvent.self) { route.append(.info($0.stop)) }
		.handleEvent(StopSearchEvent.self) { route.append(.search) }
	}
}

enum BusStopStep: Hashable {
	case schedule(Stop)
	case info(Stop)
	case search
}

struct BusStopRouter_Previews: PreviewProvider {
	static var previews: some View {
		BusStopRouter()
			.environment(\.stops, .value(.example))
	}
}
