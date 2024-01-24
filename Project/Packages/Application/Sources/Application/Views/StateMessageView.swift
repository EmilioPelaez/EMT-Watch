//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import SwiftUI

struct StateMessageView<T>: View {
	let state: Transient<T>
	
	init(state: Transient<T>) {
		self.state = state
	}
	
	var body: some View {
		switch state {
		case .uninitialized:
			Image(systemName: "ellipsis.circle")
				.font(.system(size: 50))
				.foregroundColor(.yellow)
		case .loading, .reloading:
			ProgressView()
		case .empty, .value:
			Image(systemName: "nosign.app")
				.font(.system(size: 50))
				.foregroundColor(.primary)
		case .failure:
			Image(systemName: "bolt.horizontal.circle")
				.font(.system(size: 50))
				.foregroundColor(.red)
		}
	}
}

struct StateMessageView_Previews: PreviewProvider {
	static var previews: some View {
		StateMessageView(state: Transient<String>.uninitialized)
		StateMessageView(state: Transient<String>.loading)
		StateMessageView(state: Transient<String>.value(""))
		StateMessageView(state: Transient<String>.failure(nil, DummyError()))
	}
}

struct DummyError: Error {}
