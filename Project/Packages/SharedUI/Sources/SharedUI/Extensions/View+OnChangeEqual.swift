//
//  View+OnChangeEqual.swift
//  UISupport
//
//  Created by Emilio Peláez on 13/02/22.
//

import SwiftUI

public extension View {
	func onChange<T: Equatable>(of value: T, equals baseline: T, perform: @escaping (T) -> Void) -> some View {
		onChange(of: value) { newValue in
			guard newValue == baseline else { return }
			perform(newValue)
		}
	}
	
	func onChange<T: Equatable>(of value: T, equals baseline: T, perform: @escaping () -> Void) -> some View {
		onChange(of: value, equals: baseline) { _ in
			perform()
		}
	}
}
