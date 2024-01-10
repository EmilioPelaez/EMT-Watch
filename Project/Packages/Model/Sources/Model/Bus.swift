//
//  Created by Emilio Peláez on 10/5/23.
//

import Foundation

public struct Bus: Identifiable {
	public enum ETA {
		case next
		case minutes(Int)
		case time(String)
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

public extension [Bus] {
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
		case let .minutes(int): return "\(int) min"
		case let .time(time): return time
		case .unknown: return "??"
		}
	}
}

extension Bus.ETA: Comparable {
	public static func < (lhs: Bus.ETA, rhs: Bus.ETA) -> Bool {
		switch (lhs, rhs) {
		case (.next, _), (_, .unknown), (.minutes, .time): return true
		case (_, .next), (.unknown, _), (.time, .minutes): return false
		case(.time, .time): return true
		case let (.minutes(minutesL), .minutes(minutesR)): return minutesL < minutesR
		}
	}
}
