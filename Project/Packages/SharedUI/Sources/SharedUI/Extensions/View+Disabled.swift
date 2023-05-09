//
//  Created by Emilio Peláez on 17/1/23.
//

import SwiftUI

public extension View {
	func visiblyDisabled(_ disabled: Bool) -> some View {
		self
			.disabled(disabled)
			.opacity(disabled ? 0.5 : 1)
			.grayscale(disabled ? 1 : 0)
	}
}
