//
//  Created by Emilio Peláez on 10/5/23.
//

import Model
import SwiftUI

struct MessageScreen<T>: View {
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
			Image(systemName: "checkmark.seal.fill")
				.font(.system(size: 50))
				.foregroundColor(.primary)
		case .failure:
			Image(systemName: "bolt.horizontal.circle")
				.font(.system(size: 50))
				.foregroundColor(.red)
		}
	}
}

struct MessageScreen_Previews: PreviewProvider {
	static var previews: some View {
		MessageScreen(state: DataState<String>.uninitialized)
		MessageScreen(state: DataState<String>.loading)
		MessageScreen(state: DataState<String>.value(""))
		MessageScreen(state: DataState<String>.failure)
	}
}
