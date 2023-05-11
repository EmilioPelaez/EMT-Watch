//
//  Created by Emilio Peláez on 10/5/23.
//

import SharedUI
import SwiftUI

struct StopListScreen: View {
	@Environment(\.triggerEvent) var triggerEvent
	
	@State var stationNumber: String = ""
	@FocusState var focused: Bool
	var body: some View {
		List {
			Section("Favorites") {
				StopRow(stop: .example, isFavorite: true)
			}
			Section("Nearby") {
				StopRow(stop: .example, isFavorite: false)
				StopRow(stop: .example, isFavorite: false)
				StopRow(stop: .example, isFavorite: false)
			}
			Section("By Station Number") {
				TextField("Station Number", text: $stationNumber)
					.onAppear { stationNumber = "" }
					.onSubmit { triggerEvent(StationSelectedEvent(station: stationNumber)) }
			}
		}
		.navigationTitle("Select Stop")
	}
}

struct StopListScreen_Previews: PreviewProvider {
	static var previews: some View {
		StopListScreen()
	}
}
