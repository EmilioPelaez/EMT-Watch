//
//  Created by Emilio Peláez on 14/5/23.
//

import HierarchyResponder
import Model
import SwiftUI

struct SearchScreen: View {
	let searchTerm: String
	let stops: [Stop]
	
	var filtered: [Stop] {
		stops.filter { $0.searchTerm.contains(searchTerm.lowercased()) }
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
		.navigationTitle("Search")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct SearchScreen_Previews: PreviewProvider {
	static var previews: some View {
		SearchScreen(searchTerm: "Ruzafa", stops: .example)
	}
}
