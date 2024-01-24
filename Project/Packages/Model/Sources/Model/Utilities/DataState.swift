//
//  Created by Emilio Peláez on 11/5/23.
//

import Foundation

public enum Transient<Value> {
	case uninitialized
	case loading
	case empty
	case value(Value)
	case reloading(Value)
	case failure(Value?, Error)
}

public extension Transient {
	
	var isLoading: Bool {
		switch self {
		case .loading, .reloading: true
		case _: false
		}
	}
	
	var value: Value? {
		switch self {
		case .value(let value), .reloading(let value): value
		case .failure(let value, _): value
		case _: nil
		}
	}
	
	mutating func start() {
		switch self {
		case .uninitialized, .loading, .empty:
			
			self = .loading
		case .value(let value), .reloading(let value):
			self = .reloading(value)
		case .failure(let value, _):
			if let value {
				self = .reloading(value)
			} else {
				self = .loading
			}
		}
	}
	
	mutating func set(_ newValue: Value?) {
		guard let newValue else {
			self = .empty
			return
		}
		switch self {
		case .uninitialized, .loading, .empty:
			self = .value(newValue)
		case .value, .reloading, .failure:
			self = .value(newValue)
		}
	}
	
	mutating func fail(with error: Error) {
		switch self {
		case .uninitialized, .loading, .empty:
			self = .failure(nil, error)
		case .value(let value), .reloading(let value):
			self = .failure(value, error)
		case .failure(let value, _):
			self = .failure(value, error)
		}
	}
	
	mutating func load(_ closure: (Value?) async throws -> Value?) async throws {
		start()
		do {
			let value = try await closure(value)
			set(value)
		} catch {
			fail(with: error)
			throw error
		}
	}
	
	mutating func load(_ closure: () async throws -> Value?) async throws {
		start()
		do {
			let value = try await closure()
			set(value)
		} catch {
			fail(with: error)
			throw error
		}
	}
}

extension Transient: CustomStringConvertible {
	public var description: String {
		switch self {
		case .uninitialized: "uninitialized"
		case .loading: "loading"
		case .empty: "empty"
		case .value(let value): "value \(value)"
		case .reloading(let value): "reloading \(value)"
		case .failure(let value, let error): "failure \(value) \(error)"
		}
	}
}
