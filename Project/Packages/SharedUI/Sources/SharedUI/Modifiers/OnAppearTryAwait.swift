//
//  Created by Emilio Peláez on 1/5/23.
//

import HierarchyResponder
import SwiftUI

struct OnAppearTryAwait: ViewModifier {
	@Environment(\.reportError) private var reportError
	
	let priority: TaskPriority?
	let action: () async throws -> Void
	
	func body(content: Content) -> some View {
		content
			.onAppear {
				Task(priority: priority) {
					do {
						try await action()
					} catch {
						reportError(error)
					}
				}
			}
	}
}

public extension View {
	func onAppear(_ priority: TaskPriority? = nil, perform action: @escaping () async throws -> Void) -> some View {
		modifier(OnAppearTryAwait(priority: priority, action: action))
	}
}
