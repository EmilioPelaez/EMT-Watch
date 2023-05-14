//
//  LocationProviderViewModifier.swift
//  UISupport
//
//  Created by Emilio Peláez on 20/02/22.
//

import SwiftUI

struct LocationProviderViewModifier: ViewModifier {
	@StateObject var locationManager = LocationManager()
	
	func body(content: Content) -> some View {
		content
			.onAppear(perform: locationManager.requestAuthorization)
			.onAppear(perform: locationManager.start)
			.onDisappear(perform: locationManager.stop)
			.environment(\.location, locationManager.location)
	}
}

public extension View {
	func locationProvider() -> some View {
		modifier(LocationProviderViewModifier())
	}
}
