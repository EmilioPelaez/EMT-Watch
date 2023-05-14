//
//  Created by Emilio Peláez on 18/12/22.
//

import CoreLocation
import SwiftUI

struct LocationDemoProviderModifier: ViewModifier {
	
	let location: CLLocation
	
	func body(content: Content) -> some View {
		content
			.environment(\.location, location)
	}
}

public extension View {
	func locationDemoProvider(_ location: CLLocation) -> some View {
		modifier(LocationDemoProviderModifier(location: location))
	}
}
