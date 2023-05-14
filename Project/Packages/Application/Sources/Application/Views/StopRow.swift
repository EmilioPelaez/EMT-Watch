//
//  Created by Emilio Peláez on 11/5/23.
//

import HierarchyResponder
import Model
import SharedUI
import SwiftUI

struct StopRow: View {
	@Environment(\.triggerEvent) var triggerEvent
	
	let stop: Stop
	let isFavorite: Bool
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(Image(systemName: isFavorite ? "star.fill" : "bus.fill"))
				.font(.caption2)
			+ Text(" " + stop.name)
				.font(.caption)
			Divider()
			FlowLayout(alignment: .topLeading, spacing: .paddingSmall) {
				ForEach(stop.lines) { line in
					LineBadge(name: line.lineNumber)
				}
			}
		}
		.extendHorizontally(alignment: .leading)
		.mediumPadding(.vertical)
		.swipeActions(edge: .trailing, allowsFullSwipe: true) {
			EventButton(FavoritedStopEvent(stop: stop)) {
				Image(systemName: isFavorite ? "star.slash" : "star")
			}
			EventButton(StopInfoEvent(stop: stop)) {
				Image(systemName: "info.circle")
			}
		}
	}
}

struct StopRow_Previews: PreviewProvider {
	static var previews: some View {
		List {
			StopRow(stop: .example, isFavorite: true)
			StopRow(stop: .example, isFavorite: false)
		}
	}
}
