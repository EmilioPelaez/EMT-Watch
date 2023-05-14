//
//  Created by Emilio Peláez on 14/5/23.
//

import CoreLocation
import Foundation
import Model

enum BusStopSorter {
	static func sort(_ stops: [Stop], favorites: [String], location: CLLocation?) -> (favorites: [Stop], nearby: [Stop], all: [Stop]) {
		var favoriteStops = stops
			.filter { favorites.contains($0.id) }
		guard let location else {
			return (favoriteStops, [], stops)
		}
		favoriteStops.sort { location.distance(from: $0.coordinate) < location.distance(from: $1.coordinate) }
		let nearbyStops = stops
			.sorted { location.distance(from: $0.coordinate) < location.distance(from: $1.coordinate) }
			.filter { location.distance(from: $0.coordinate) < 500 }
		return (favoriteStops, Array(nearbyStops), stops)
	}
}

extension CLLocation {
	func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
		distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
	}
}
