//
//  Created by Emilio Peláez on 10/5/23.
//

import SharedUI
import SwiftUI

struct StopSearchView: View {
	@State var station: String = ""
	@FocusState var focused: Bool
	
	var body: some View {
		VStack {
			TextField("Station", text: $station)
				.focused($focused)
			Spacer()
			Button("Go") {}
				.foregroundStyle(.green)
				.visiblyDisabled(station.isEmpty)
		}
	}
}

struct StopSearchView_Previews: PreviewProvider {
	static var previews: some View {
		StopSearchView()
	}
}
