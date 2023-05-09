//
//  Created by Emilio Peláez on 29/1/23.
//

import SwiftUI

public extension View {
	func onAppear(after delay: TimeInterval, perform task: @escaping () -> Void) -> some View {
		onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(delay * 1000)), execute: task)
		}
	}
}
