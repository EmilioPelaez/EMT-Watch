//
//  LocationManager.swift
//  UISupport
//
//  Created by Emilio Peláez on 20/02/22.
//

import Combine
import CoreLocation

public class LocationManager: NSObject, ObservableObject {
	
	@Published public private(set) var location: CLLocation?
	
	let locationManager = CLLocationManager()
	
	override public init() {
		super.init()
		
		self.location = locationManager.location
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
	}
	
	func requestAuthorization() {
		locationManager.requestWhenInUseAuthorization()
	}
	
	func start() {
		locationManager.startUpdatingLocation()
	}
	
	func stop() {
		locationManager.stopUpdatingLocation()
	}
	
}

extension LocationManager: CLLocationManagerDelegate {
	public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let lastLocation = locations.last else { return }
		DispatchQueue.main.async { [self] in
			location = lastLocation
		}
	}
}
