//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import SwiftUI

struct BusETAView: View {
	let eta: Bus.ETA
	
	var body: some View {
		Group {
			switch eta {
			case .next:
				Text("now")
					.foregroundColor(.green)
			case let .minutes(minutes):
				Text("\(minutes) min")
					.foregroundColor(minutes <= 5 ? .green : .primary)
			case let .time(time):
				Text(time)
					.foregroundColor(.primary)
			case .unknown:
				Text("??")
					.foregroundColor(.red)
			}
		}
		.font(.system(.body, design: .rounded, weight: .regular))
		.monospacedDigit()
	}
}

struct BusETAView_Previews: PreviewProvider {
	static var previews: some View {
		BusETAView(eta: .next)
		BusETAView(eta: .minutes(1))
		BusETAView(eta: .minutes(10))
		BusETAView(eta: .unknown)
	}
}
