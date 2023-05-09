//
//  Created by Emilio Peláez on 17/1/23.
//

import Foundation

@propertyWrapper
public struct UserSetting<T> {
	let key: String
	let suite: UserDefaults
	let defaultValue: T
	
	public init(_ key: String, suite: UserDefaults = .standard, defaultValue: T) {
		self.key = key
		self.suite = suite
		self.defaultValue = defaultValue
	}
	
	public var wrappedValue: T {
		get { suite.object(forKey: key) as? T ?? defaultValue }
		set { suite.set(newValue, forKey: key) }
	}
}
