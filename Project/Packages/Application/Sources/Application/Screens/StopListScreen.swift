//
//  Created by Emilio Peláez on 10/5/23.
//

import HierarchyResponder
import Model
import SharedUI
import SwiftUI

struct StopListScreen: View {
	@Environment(\.stops) var stops
	@Environment(\.favorites) var favorites
	
	var body: some View {
		Group {
			switch stops {
			case .value(let stops):
				ContentView(favorites: stops, nearby: stops)
			case _:
				MessageScreen(state: stops)
			}
		}
		.navigationTitle("Select Stop")
	}
}

extension StopListScreen {
	struct ContentView: View {
		@Environment(\.triggerEvent) var triggerEvent
		
		let favorites: [Stop]
		let nearby: [Stop]
		
		@State var stationNumber: String = ""
		
		var body: some View {
			List {
				Section("Favorites") {
					ForEach(favorites) { stop in
						EventButton(StopSelectedEvent(stop: stop)) {
							StopRow(stop: stop, isFavorite: true)
						}
					}
				}
				Section("Nearby") {
					ForEach(nearby) { stop in
						EventButton(StopSelectedEvent(stop: stop)) {
							StopRow(stop: stop, isFavorite: false)
						}
					}
				}
				Section("By Station Number") {
					TextField("Station Number", text: $stationNumber)
						.onAppear { stationNumber = "" }
//						.onSubmit { triggerEvent(StationSelectedEvent(station: stationNumber)) }
				}
			}
		}
	}
}

struct StopListScreen_Previews: PreviewProvider {
	static var previews: some View {
		StopListScreen()
			.environment(\.stops, .value(.example))
	}
}
