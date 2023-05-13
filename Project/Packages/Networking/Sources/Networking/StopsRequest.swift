//
//  Created by Emilio Peláez on 12/5/23.
//

import Monarch

public struct StopsRequest: Request {
	public var path: String = ""
	
	public var preview: Response = .init()
	
	public init() {}
}

extension StopsRequest {
	public struct Response: Decodable {
		
	}
}
