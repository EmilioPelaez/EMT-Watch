//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import SwiftUI

struct BusLineView: View {
	let bus: Bus
	
	var body: some View {
		HStack(alignment: .firstTextBaseline) {
			LineBadge(name: bus.linea)
			Text(bus.destination)
				.font(.caption2)
				.minimumScaleFactor(0.5)
				.lineLimit(1)
			Spacer()
			BusETAView(eta: .next)
				.layoutPriority(1)
		}
	}
}

struct BusLineView_Previews: PreviewProvider {
	static var previews: some View {
		BusLineView(bus: .example)
	}
}
