//
//  Created by Emilio Peláez on 14/5/23.
//

import Foundation
import HierarchyResponder

struct CaughtError: AlertableError {
	var title: String? { "Uh oh!" }
	var message: String {
		#if DEBUG
		(error as NSError).description
		#else
		error.localizedDescription
		#endif
	}
	
	let error: Error
}
