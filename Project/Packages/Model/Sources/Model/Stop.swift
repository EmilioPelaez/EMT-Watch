//
//  Created by Emilio Peláez on 11/5/23.
//

import CoreLocation
import Foundation

public struct Stop: Identifiable {
	public let id: String
	public let name: String
	public let address: String
	public let coordinate: CLLocationCoordinate2D
	public let lines: [Line]
	
	public init(id: String, name: String, address: String, coordinate: CLLocationCoordinate2D, lines: [Line]) {
		self.id = id
		self.name = name
		self.address = address
		self.coordinate = coordinate
		self.lines = lines
	}
}

extension Stop: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(name)
		hasher.combine(address)
		hasher.combine(coordinate.latitude)
		hasher.combine(coordinate.longitude)
		hasher.combine(lines.hashValue)
	}
	
	public static func == (lhs: Stop, rhs: Stop) -> Bool {
		lhs.id == rhs.id
	}
}

public extension Stop {
	static let example = Stop(id: "729",
	                          name: "Ruzafa",
	                          address: "REINO DE VALENCIA",
	                          coordinate: CLLocationCoordinate2D(latitude: 39.470022, longitude: -0.376823),
	                          lines: [.example, .example, .example])
}

public extension [Stop] {
	static let example = [Stop.example]
}

public extension Stop {
	var searchTerm: String {
		[id, name, address].joined(separator: " ").lowercased()
	}
}
