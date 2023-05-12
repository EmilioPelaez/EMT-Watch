//
//  Created by Emilio Peláez on 12/5/23.
//

import Monarch

struct StopsRequest: Request {
	var path: String
	
	var preview: Response = .init()
}

extension StopsRequest {
	struct Response: Decodable {
		
	}
}
