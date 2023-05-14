//
//  Created by Emilio Peláez on 14/5/23.
//

import HierarchyResponder
import Model
import SwiftUI

struct FavoritesProvider: ViewModifier {
	//	Wish AppStorage supported arrays, but whatever
	@AppStorage("Favorites") var favorites: String = ""
	
	func body(content: Content) -> some View {
		content
			.handleEvent(FavoritedStopEvent.self) { updateFavorites(with: $0.stop) }
			.environment(\.favorites, favorites.components(separatedBy: ","))
	}
	
	func updateFavorites(with stop: Stop) {
		var array = favorites.components(separatedBy: ",")
		if array.contains(stop.id) {
			array.removeAll { $0 == stop.id }
		} else {
			array.append(stop.id)
		}
		favorites = array
			.filter { !$0.isEmpty }
			.joined(separator: ",")
	}
}

extension View {
	func favoritesProvider() -> some View {
		modifier(FavoritesProvider())
	}
}
