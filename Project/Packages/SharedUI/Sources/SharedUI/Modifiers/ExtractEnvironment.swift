//
//  Created by Emilio Peláez on 1/5/23.
//

import SwiftUI

struct ExtractEnvironment<V: Equatable>: ViewModifier {
	@Environment(\.self) var environment
	
	let path: KeyPath<EnvironmentValues, V>
	let binding: Binding<V>
	
	init(path: KeyPath<EnvironmentValues, V>, binding: Binding<V>) {
		self.path = path
		self.binding = binding
	}
	
	func body(content: Content) -> some View {
		content
			.onChange(of: environment[keyPath: path]) { newValue in
				binding.wrappedValue = newValue
			}
	}
}

public extension View {
	func extractEnvironment<V: Equatable>(_ path: KeyPath<EnvironmentValues, V>, into binding: Binding<V>) -> some View {
		modifier(ExtractEnvironment(path: path, binding: binding))
	}
}
