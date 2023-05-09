//
//  Created by Emilio Peláez on 10/5/23.
//

import SwiftUI

struct EmptyBusesView: View {
	var body: some View {
		Image(systemName: "bolt.horizontal.circle")
			.font(.system(size: 50))
			.foregroundColor(.red)
	}
}

struct EmptyBusesView_Previews: PreviewProvider {
	static var previews: some View {
		EmptyBusesView()
	}
}
