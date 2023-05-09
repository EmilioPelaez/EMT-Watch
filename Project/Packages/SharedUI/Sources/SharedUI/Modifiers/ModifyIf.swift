//
//  Created by Emilio Peláez on 29/1/23.
//

import SwiftUI

public extension View {
	@ViewBuilder
	func `if`<Content>(_ condition: Bool,
	                   _ ifBuilder: (Self) -> Content) ->
		some View where Content: View {
		if condition {
			ifBuilder(self)
		} else {
			self
		}
	}
	
	@ViewBuilder
	func `if`<I, E>(_ condition: Bool,
	                _ ifBuilder: (Self) -> I,
	                else elseBuilder: (Self) -> E) ->
		some View where I: View, E: View {
		if condition {
			ifBuilder(self)
		} else {
			elseBuilder(self)
		}
	}
}
