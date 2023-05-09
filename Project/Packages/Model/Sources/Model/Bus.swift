//
//  Created by Emilio Peláez on 10/5/23.
//

import Foundation

public struct Bus: Identifiable {
	public enum ETA {
		case next
		case minutes(Int)
		case unknown
	}
	
	public var id: String {
		linea + destination + eta.description
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

public extension Array<Bus> {
	static let example = [
		Bus(linea: "19", destination: "La Malvarosa", eta: .next),
		Bus(linea: "6", destination: "Hospital La Fe", eta: .minutes(3)),
		Bus(linea: "19", destination: "La Malvarosa", eta: .minutes(12)),
		Bus(linea: "6", destination: "Hospital La Fe", eta: .unknown),
	]
}

extension Bus.ETA: CustomStringConvertible {
	public var description: String {
		switch self {
		case .next: return "now"
		case .minutes(let int): return "\(int) min"
		case .unknown: return "??"
		}
	}
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
