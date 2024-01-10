//
//  Created by Emilio Peláez on 14/5/23.
//

import HierarchyResponder
import Model
import SwiftUI

struct SearchScreen: View {
	@Environment(\.stops) var stopsData
	@State var searchTerm: String = ""
	
	var stops: [Stop] {
		switch stopsData {
		case let .value(stops): return stops
		case _: return []
		}
	}
	
	var filtered: [Stop] {
		let term = searchTerm.trimmingCharacters(in: .whitespaces)
		if term.isEmpty {
			return stops
		} else {
			return stops.filter { $0.searchTerm.contains(term.lowercased()) }
		}
	}
	
	var body: some View {
		Group {
			if filtered.isEmpty {
				VStack {
					Image(systemName: "magnifyingglass")
						.font(.system(size: 50))
						.foregroundColor(.primary)
					Text("No Results")
				}
			} else {
				List {
					ForEach(filtered) { stop in
						EventButton(StopSelectedEvent(stop: stop)) {
							StopRow(stop: stop, isFavorite: false)
						}
					}
				}
			}
		}
		.searchable(text: $searchTerm)
		.autocorrectionDisabled(true)
		.navigationTitle("Search")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct SearchScreen_Previews: PreviewProvider {
	static var previews: some View {
		SearchScreen()
			.environment(\.stops, .value(.example))
	}
}
