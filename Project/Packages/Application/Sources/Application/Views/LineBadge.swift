//
//  Created by Emilio Peláez on 10/5/23.
//

import SwiftUI

struct LineBadge: View {
	let name: String
	
	var body: some View {
		Text("XX")
			.font(.system(.callout, design: .rounded, weight: .medium))
			.padding(5)
			.overlay {
				ZStack {
					Circle()
						.foregroundStyle(.red)
					Text(name)
						.font(.system(.callout, design: .rounded, weight: .medium))
						.minimumScaleFactor(0.25)
						.foregroundColor(.white)
				}
			}
	}
}

struct LineBadge_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			LineBadge(name: "19")
			LineBadge(name: "9")
			LineBadge(name: "hello")
		}
	}
}
