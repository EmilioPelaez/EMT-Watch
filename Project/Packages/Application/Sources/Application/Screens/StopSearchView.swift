//
//  Created by Emilio Peláez on 10/5/23.
//

import SharedUI
import SwiftUI

struct StopSearchView: View {
	@Environment(\.triggerEvent) var triggerEvent
	
	@State var station: String = ""
	@FocusState var focused: Bool
	
	var body: some View {
		VStack {
			TextField("Station Number", text: $station)
				.onSubmit { triggerEvent(StationSelectedEvent(station: station)) }
			Spacer()
		}
		.navigationTitle("Select Stop")
	}
}

struct StopSearchView_Previews: PreviewProvider {
	static var previews: some View {
		StopSearchView()
	}
}
