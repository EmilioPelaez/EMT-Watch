//
//  Created by Emilio Peláez on 19/1/23.
//

import SwiftUI

public extension View {
	func safePadding(edges: Edge.Set = .all, _ length: CGFloat = .paddingMedium) -> some View {
		GeometryReader { geo in
			padding(.bottom, edges.contains(.bottom) ? max(length, geo.safeAreaInsets.bottom) : 0)
				.padding(.top, edges.contains(.top) ? max(length, geo.safeAreaInsets.top) : 0)
				.padding(.leading, edges.contains(.leading) ? max(length, geo.safeAreaInsets.leading) : 0)
				.padding(.trailing, edges.contains(.trailing) ? max(length, geo.safeAreaInsets.trailing) : 0)
				.ignoresSafeArea(edges: edges)
		}
	}
}
