//
//  Created by Emilio Peláez on 11/5/23.
//

import HierarchyResponder
import MapKit
import Model
import SharedUI
import SwiftUI

struct StopInfoScreen: View {
	@Environment(\.favorites) var favorites
	
	let stop: Stop
	
	@State var coordinate: MKCoordinateRegion
	
	var isFavorite: Bool {
		favorites.contains(stop.id)
	}
	
	init(stop: Stop) {
		self.stop = stop
		self.coordinate = .init(center: stop.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
	}
	
	var body: some View {
		List {
			VStack(alignment: .leading) {
				Label(stop.name, systemImage: "bus.fill")
				.font(.body)
				Label(stop.address, systemImage: "mappin.circle")
					.font(.caption2.smallCaps())
					.foregroundColor(.secondary)
				FlowLayout(alignment: .topLeading, spacing: .paddingTiny) {
					ForEach(stop.lines) { line in
						LineBadge(name: line.lineNumber)
					}
				}
			}
			.extendHorizontally(alignment: .leading)
			.mediumPadding(.vertical)
			Map(coordinateRegion: $coordinate,
					interactionModes: [],
					showsUserLocation: true,
					userTrackingMode: nil,
					annotationItems: [stop]) { stop in
				MapMarker(coordinate: stop.coordinate, tint: .red)
			}
					.frame(height: 100)
					.listRowInsets(EdgeInsets())
					.clipShape(RoundedRectangle(cornerRadius: 10))
			EventButton(FavoritedStopEvent(stop: stop)) {
				Label(isFavorite ? "Remove Favorite" : "Add Favorite",
							systemImage: isFavorite ? "star.fill" : "star")
			}
		}
		.navigationTitle("Details")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct StopInfoScreen_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			StopInfoScreen(stop: .example)
		}
		NavigationStack {
			StopInfoScreen(stop: .example)
				.environment(\.favorites, [Stop.example.id])
		}
	}
}
