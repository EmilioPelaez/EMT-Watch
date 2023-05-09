//
//  Created by Emilio Peláez on 27/2/23.
//

import SwiftUI

public struct VerticalLabeledContentStyle: LabeledContentStyle {
	public func makeBody(configuration: Configuration) -> some View {
		VStack(alignment: .leading, spacing: 0) {
			configuration.label
				.font(.subheadline.smallCaps())
				.foregroundColor(.secondary)
			configuration.content
				.font(.body)
				.foregroundColor(.primary)
		}
	}
}

public extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
	static var vertical: VerticalLabeledContentStyle { .init() }
}
