//
//  Created by Emilio Peláez on 14/5/23.
//

import HierarchyResponder
import Model

struct StopSearchEvent: Event {
	let searchTerm: String
	let stops: [Stop]
}
