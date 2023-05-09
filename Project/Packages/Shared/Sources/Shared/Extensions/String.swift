//
//  Created by Emilio Peláez on 28/1/23.
//

import Foundation

public extension String {

	var notEmptyOrNil: String? {
		isEmpty ? nil : self
	}
	
	var asData: Data? {
		data(using: String.Encoding.utf8)
	}
	
}

public extension String {
	
	func trimmed() -> String {
		trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	func removingOccurrences(of string: String) -> String {
		replacingOccurrences(of: string, with: "")
	}
	
	func toBase64() -> String? {
		guard let data = data(using: String.Encoding.utf8) else {
			return nil
		}
		return data.base64EncodedString(options: [])
	}
	
}
