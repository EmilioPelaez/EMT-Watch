//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import SharedUI
import SwiftUI

struct BusListView: View {
	let station: String
	let buses: [Bus]
	
	var body: some View {
		ScrollView {
			VStack {
				HStack {
					Image(systemName: "bus.fill")
					Text(station)
				}
				.font(.caption2)
				.extendHorizontally(alignment: .leading)
				Divider()
				ForEach(buses) { bus in
					IncomingBusView(bus: bus)
				}
			}
		}
	}
}

struct BusListView_Previews: PreviewProvider {
	static var previews: some View {
		BusListView(station: "728", buses: .example)
	}
}
