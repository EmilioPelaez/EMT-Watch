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
	@Environment(\.location) var location
	
	var body: some View {
		Group {
			switch stops {
			case .value(let stops):
				let filtered = BusStopSorter.sort(stops, favorites: favorites, location: location)
				ContentView(favorites: filtered.favorites, nearby: filtered.nearby, all: filtered.all)
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
		let all: [Stop]
		
		@State var searchTerm: String = ""
		
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
				//	This doesn't work for some reason
//				Section("Search") {
//					TextField("Name, Address or ID", text: $searchTerm)
//						.onSubmit {
//							triggerEvent(StopSearchEvent(searchTerm: searchTerm, stops: all))
//						}
//				}
			}
			.searchable(text: $searchTerm)
			.autocorrectionDisabled(true)
			.onChange(of: searchTerm) {
				guard !$0.isEmpty else { return }
				triggerEvent(StopSearchEvent(searchTerm: $0, stops: all))
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
