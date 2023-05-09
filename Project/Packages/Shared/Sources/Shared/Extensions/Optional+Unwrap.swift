//
//  Created by Emilio Peláez on 10/07/22.
//

import Foundation

public extension Optional {
	struct NilValueError: Error {
		let optional: Wrapped?
		private let message: String
		fileprivate init(_ optional: Wrapped?) {
			self.optional = optional
			self.message = "Optional value of type " + String(describing: Wrapped.self) + " was nil at the time of unwrapping"
		}
	}
	
	func unwrap(with error: Error? = nil) throws -> Wrapped {
		switch self {
		case .none:
			throw error ?? NilValueError(self)
		case let .some(wrapped):
			return wrapped
		}
	}
}

extension Optional.NilValueError: CustomStringConvertible, CustomDebugStringConvertible {
	public var localizedDescription: String { message }
	
	public var description: String { message }
	
	public var debugDescription: String {
		String(describing: type(of: self)) + ": " + message
	}
}
