//
//  Created by Emilio Peláez on 11/5/23.
//

import Foundation

public struct Stop: Identifiable {
	public let id: String
	public let name: String
	public let address: String
//	public let location: CLLocation
	public let lines: [Line]
	
	public init(id: String, name: String, address: String, lines: [Line]) {
		self.id = id
		self.name = name
		self.address = address
		self.lines = lines
	}
}

public extension Stop {
	static let example = Stop(id: "729", name: "Ruzafa", address: "REINO DE VALENCIA", lines: [.example, .example, .example])
}
