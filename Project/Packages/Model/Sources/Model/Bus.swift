//
//  Created by Emilio Peláez on 10/5/23.
//

import Foundation

public struct Bus {
	public enum ETA {
		case next
		case minutes(Int)
		case unknown
	}
	
	public let linea: String
	public let destination: String
	public let eta: ETA
	
	public init(linea: String, destination: String, eta: ETA) {
		self.linea = linea
		self.destination = destination
		self.eta = eta
	}
}

public extension Bus {
	static let example = Bus(linea: "19", destination: "La Malvarosa", eta: .minutes(3))
}

extension Bus.ETA: Comparable {
	public static func <(lhs: Bus.ETA, rhs: Bus.ETA) -> Bool {
		switch (lhs, rhs) {
		case (.next, _), (_, .unknown): return true
		case (_, .next), (.unknown, _): return false
		case (.minutes(let ml), .minutes(let mr)): return ml < mr
		}
	}
}
