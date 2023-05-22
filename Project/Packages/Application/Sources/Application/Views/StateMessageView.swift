//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import SwiftUI

struct StateMessageView<T>: View {
	let state: DataState<T>
	
	var body: some View {
		switch state {
		case .uninitialized:
			Image(systemName: "ellipsis.circle")
				.font(.system(size: 50))
				.foregroundColor(.primary)
		case .loading:
			ProgressView()
		case .value:
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
		StateMessageView(state: DataState<String>.uninitialized)
		StateMessageView(state: DataState<String>.loading)
		StateMessageView(state: DataState<String>.value(""))
		StateMessageView(state: DataState<String>.failure)
	}
}
