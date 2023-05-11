//
//  Created by Emilio Peláez on 11/5/23.
//

import Foundation

enum DataState<T> {
	case uninitialized
	case loading
	case value(T)
	case failure
}
