//
//  Created by Emilio Peláez on 10/5/23.
//

import SwiftUI

struct LineBadge: View {
	let name: String
	
	var body: some View {
		Text(name)
			.font(.system(.callout, design: .rounded, weight: .medium))
			.foregroundColor(.white)
			.padding(5)
			.background {
				Circle()
					.foregroundStyle(.red)
			}
	}
}

struct LineBadge_Previews: PreviewProvider {
	static var previews: some View {
		LineBadge(name: "19")
	}
}
