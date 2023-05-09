//
//  Created by Emilio Peláez on 28/1/23.
//

import UIKit

public extension Bundle {
	
	/**
	 BundleVersion uses the CFBundleShortVersionString and CFBundleVersion keys to get the version number and build
	 of a given bundle (Like a UIApplication).
	 While the build can be anything, like "beta 1", the number has to be of the form X.X.X with as many decimal points as needed.
	 
	 There are two main uses for this struct:
	 
	 The first one is to display the version number and build to the user, which is why these two values are stored as strings during
	 initialization. BundleVersion also conforms to the CustomStringComparable protocol, so calling `description` on it will return
	 a string of the form "NUMBER (BUILD)" if a build value is available, or just "NUMBER" if it isn't.
	 
	 The second use for this struct is to compare two BundleVersions, this can be useful if you want to use features only available
	 in a certain version of the bundle. BundleVersion conforms to the Equatable and Comparable protocols.
	 When comparing two versions, only the version number will be utilized, the build value will be ignored.
	 */
	
	struct Version {
		
		public let numberString: String
		public let buildString: String?
		
		public let numberComponents: [Int]
		
		public init(bundle: Bundle) {
			let numberString: String = {
				guard let string = (bundle.infoDictionary?["CFBundleShortVersionString"] as? String)?.notEmptyOrNil else {
					assertionFailure("Key CFBundleShortVersionString not found in Info.plist")
					return "0.0"
				}
				return string
			}()
			
			let buildString: String? = {
				guard let string = (bundle.infoDictionary?["CFBundleVersion"] as? String)?.notEmptyOrNil else {
					print("Key CFBundleVersion not found in Info.plist")
					return nil
				}
				return string
			}()
			
			self.init(numberString: numberString, buildString: buildString)
		}
		
		public init(numberString: String, buildString: String? = nil) {
			self.numberString = numberString
			self.buildString = buildString?.notEmptyOrNil
			
			let formatter = NumberFormatter()
			formatter.numberStyle = .decimal
			
			self.numberComponents = numberString
				.components(separatedBy: ".")
				.map { formatter.number(from: $0)?.intValue ?? 0 }
		}
		
	}
}

public extension Bundle {
	var version: Bundle.Version {
		.init(bundle: self)
	}
}

extension Bundle.Version: CustomStringConvertible {
	public var description: String {
		guard let buildString = buildString else {
			return numberString
		}
		return "\(numberString) (\(buildString))"
	}
}

extension Bundle.Version: Equatable {
	public static func == (lhs: Bundle.Version, rhs: Bundle.Version) -> Bool {
		for element in arraysMatchingLength(lhs: lhs.numberComponents, rhs: rhs.numberComponents) where element.0 != element.1 {
			return false
		}
		return true
	}
	
	fileprivate static func arraysMatchingLength(lhs: [Int], rhs: [Int]) -> ([(Int, Int)]) {
		(0 ..< max(lhs.count, rhs.count)).map { index in
			(lhs.element(at: index) ?? 0, rhs.element(at: index) ?? 0)
		}
	}
}

extension Bundle.Version: Comparable {
	public static func < (lhs: Bundle.Version, rhs: Bundle.Version) -> Bool {
		compareIntArrays(lhs: lhs.numberComponents, rhs: rhs.numberComponents, withFunction: <)
	}
	
	public static func > (lhs: Bundle.Version, rhs: Bundle.Version) -> Bool {
		compareIntArrays(lhs: lhs.numberComponents, rhs: rhs.numberComponents, withFunction: >)
	}
	
	public static func <= (lhs: Bundle.Version, rhs: Bundle.Version) -> Bool {
		lhs == rhs || lhs < rhs
	}
	
	public static func >= (lhs: Bundle.Version, rhs: Bundle.Version) -> Bool {
		lhs == rhs || lhs > rhs
	}
	
	private static func compareIntArrays(lhs: [Int], rhs: [Int], withFunction function: (Int, Int) -> Bool) -> Bool {
		for element in arraysMatchingLength(lhs: lhs, rhs: rhs) {
			if element.0 == element.1 { continue }
			return function(element.0, element.1)
		}
		return false
	}
}

public extension Bundle.Version {
	static func == (lhs: Bundle.Version, rhs: String) -> Bool {
		lhs == Bundle.Version(numberString: rhs)
	}
	
	static func < (lhs: Bundle.Version, rhs: String) -> Bool {
		lhs < Bundle.Version(numberString: rhs)
	}
	
	static func > (lhs: Bundle.Version, rhs: String) -> Bool {
		lhs > Bundle.Version(numberString: rhs)
	}
	
	static func <= (lhs: Bundle.Version, rhs: String) -> Bool {
		lhs <= Bundle.Version(numberString: rhs)
	}
	
	static func >= (lhs: Bundle.Version, rhs: String) -> Bool {
		lhs >= Bundle.Version(numberString: rhs)
	}
}

public extension Bundle.Version {
	static func == (lhs: Bundle.Version, rhs: Int) -> Bool {
		lhs == String(rhs)
	}
	
	static func < (lhs: Bundle.Version, rhs: Int) -> Bool {
		lhs < String(rhs)
	}
	
	static func > (lhs: Bundle.Version, rhs: Int) -> Bool {
		lhs > String(rhs)
	}
	
	static func <= (lhs: Bundle.Version, rhs: Int) -> Bool {
		lhs <= String(rhs)
	}
	
	static func >= (lhs: Bundle.Version, rhs: Int) -> Bool {
		lhs >= String(rhs)
	}
}

public extension Bundle.Version {
	static func == (lhs: Bundle.Version, rhs: Double) -> Bool {
		lhs == String(rhs)
	}
	
	static func < (lhs: Bundle.Version, rhs: Double) -> Bool {
		lhs < String(rhs)
	}
	
	static func > (lhs: Bundle.Version, rhs: Double) -> Bool {
		lhs > String(rhs)
	}
	
	static func <= (lhs: Bundle.Version, rhs: Double) -> Bool {
		lhs <= String(rhs)
	}
	
	static func >= (lhs: Bundle.Version, rhs: Double) -> Bool {
		lhs >= String(rhs)
	}
}

public extension Bundle.Version {
	static func == (lhs: Bundle.Version, rhs: Float) -> Bool {
		lhs == String(rhs)
	}
	
	static func < (lhs: Bundle.Version, rhs: Float) -> Bool {
		lhs < String(rhs)
	}
	
	static func > (lhs: Bundle.Version, rhs: Float) -> Bool {
		lhs > String(rhs)
	}
	
	static func <= (lhs: Bundle.Version, rhs: Float) -> Bool {
		lhs <= String(rhs)
	}
	
	static func >= (lhs: Bundle.Version, rhs: Float) -> Bool {
		lhs >= String(rhs)
	}
}
