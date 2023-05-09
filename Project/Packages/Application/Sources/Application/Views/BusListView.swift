//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import SharedUI
import SwiftUI

struct BusListView: View {
	let buses: [Bus]
	
	var body: some View {
		VStack {
			ForEach(buses) { bus in
				IncomingBusView(bus: bus)
			}
		}
	}
}

struct BusListView_Previews: PreviewProvider {
	static var previews: some View {
		BusListView(buses: .example)
	}
}
