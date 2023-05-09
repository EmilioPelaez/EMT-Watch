//
//  Created by Emilio Peláez on 18/1/23.
//

import SwiftUI

struct DetachModifier<V: View>: ViewModifier {
	let detached: (Color) -> V
	
	func body(content: Content) -> some View {
		ZStack {
			detached(.clear)
			content
		}
	}
}

public extension View {
	func detach<V: View>(@ViewBuilder _ builder: @escaping (Color) -> V) -> some View {
		modifier(DetachModifier(detached: builder))
	}
}
