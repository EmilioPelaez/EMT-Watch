//
//  Created by Emilio Peláez on 11/5/23.
//

import Foundation

public struct Line: Identifiable {
	public var id: String { lineNumber + destination }
	
	public let lineNumber: String
	public let destination: String
	
	public init(lineNumber: String, destination: String) {
		self.lineNumber = lineNumber
		self.destination = destination
	}
}

public extension Line {
	static let example = Line(lineNumber: "19", destination: "La Malvarosa")
}
