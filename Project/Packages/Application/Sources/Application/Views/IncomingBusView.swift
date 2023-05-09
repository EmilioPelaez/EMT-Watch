//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import SwiftUI

struct IncomingBusView: View {
	let bus: Bus
	
	var body: some View {
		HStack(alignment: .firstTextBaseline) {
			LineBadge(name: bus.linea)
			Text(bus.destination)
				.foregroundColor(.secondary)
				.font(.caption2)
				.minimumScaleFactor(0.5)
				.lineLimit(1)
			Spacer()
			BusETAView(eta: bus.eta)
				.layoutPriority(1)
		}
	}
}

struct IncomingBusView_Previews: PreviewProvider {
	static var previews: some View {
		IncomingBusView(bus: .example)
	}
}
