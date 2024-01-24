//
//  Created by Emilio Peláez on 28/1/23.
//

import Foundation

public extension Array where Element: Equatable {
	
	mutating func remove(_ object: Element) {
		if let index = firstIndex(of: object) {
			remove(at: index)
		}
	}
	
	func difference(to array: Array) -> (common: [Element], inserted: [Element], removed: [Element]) {
		difference(to: array, compare: ==)
	}
	
	func filterDuplicates() -> Array {
		var array = Array()
		forEach {
			guard !array.contains($0) else { return }
			array.append($0)
		}
		return array
	}
	
}

public extension Array {
	
	var notEmptyOrNil: [Element]? {
		isEmpty ? nil : self
	}
	
	func element(at index: Index) -> Element? {
		guard index >= 0, index < count else { return nil }
		return self[index]
	}
	
	func difference(to array: Array, compare: (Element, Element) throws -> Bool) rethrows -> (common: [Element], inserted: [Element], removed: [Element]) {
		let common = try filter { element in try array.contains { try compare(element, $0) } }
		let inserted = try array.filter { element in try !common.contains { try compare(element, $0) } }
		let removed = try filter { element in try !common.contains { try compare(element, $0) } }
		return (common, inserted, removed)
	}
	
}
