//
//  Environment.swift
//  UISupport
//
//  Created by Emilio Peláez on 20/02/22.
//

import CoreLocation
import SwiftUI

struct LocationEnvironmentKey: EnvironmentKey {
	static var defaultValue: CLLocation?
}

public extension EnvironmentValues {
	var location: CLLocation? {
		get { self[LocationEnvironmentKey.self] }
		set { self[LocationEnvironmentKey.self] = newValue }
	}
	
	var distanceFrom: (CLLocation) -> Double? {
		{ targetLocation in
			location.map { $0.distance(from: targetLocation) }
		}
	}
}
