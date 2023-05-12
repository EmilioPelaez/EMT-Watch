//
//  Created by Emilio Peláez on 12/5/23.
//

import Foundation
import Monarch

class EMTClient: NetworkProvider {
	var baseURL: URL = {
		guard let url = URL(string: "https://www.emtvalencia.es") else {
			fatalError("Unable to create startup URL")
		}
		return url
	}()
	
	
}
