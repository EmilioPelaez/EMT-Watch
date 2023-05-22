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
				StateMessageView(state: stops)
			}
		}
		.navigationTitle("Select Stop")
	}
}

extension StopListScreen {
	struct ContentView: View {
		@Environment(\.triggerEvent) var triggerEvent
		@Environment(\.favorites) var fav
		@Environment(\.isFavorite) var isFavorite
		
		let favorites: [Stop]
		let nearby: [Stop]
		let all: [Stop]
		
		@State var searchTerm: String = ""
		
		var body: some View {
			List {
				Section("Favorites") {
					if favorites.isEmpty {
						Label("Swipe left on a bus stop to mark as a favorite.", systemImage: "info.circle")
					} else {
						ForEach(favorites) { stop in
							EventButton(StopSelectedEvent(stop: stop)) {
								StopRow(stop: stop, isFavorite: true)
							}
						}
					}
				}
				Section("Nearby") {
					ForEach(nearby) { stop in
						EventButton(StopSelectedEvent(stop: stop)) {
							StopRow(stop: stop, isFavorite: isFavorite(stop))
						}
					}
				}
				EventButton(StopSearchEvent()) {
					Label("Search", systemImage: "magnifyingglass")
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
