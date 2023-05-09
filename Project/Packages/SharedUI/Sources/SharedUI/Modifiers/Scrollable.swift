//
//  Created by Emilio Peláez on 10/5/23.
//

import SwiftUI

struct Scrollable: ViewModifier {
	let scrollable: Bool
	let axis: Axis.Set
	let showsIndicators: Bool
	
	func body(content: Content) -> some View {
		if scrollable {
			ScrollView(axis, showsIndicators: showsIndicators) {
				content
			}
		} else {
			content
		}
	}
}

public extension View {
	func scrollable(_ scroll: Bool, axis: Axis.Set = .vertical, showsIndicators: Bool = true) -> some View {
		modifier(Scrollable(scrollable: scroll, axis: axis, showsIndicators: showsIndicators))
	}
}
