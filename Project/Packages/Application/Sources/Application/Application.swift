//
//  Created by Emilio Peláez on 10/5/23.
//

import HierarchyResponder
import SwiftUI

public struct Application: View {
	public init() {}
	
	public var body: some View {
		BusStopRouter()
			.transformError { CaughtError(error: $0) }
			.handleAlertErrors()
	}
}

struct Application_Previews: PreviewProvider {
	static var previews: some View {
		Application()
	}
}
