//
//  Created by Emilio Peláez on 12/5/23.
//

import Foundation
import Monarch

public struct BusesRequest: Request {
	let stopId: String
	
	public var path: String = "EMT/mapfunctions/MapUtilsPetitions.php"
	public var query: [String: Any] {
		["parada": stopId,
		 "sec":"getSAE",
		 "idioma":"en",
		 "adaptados":false]
	}
	public var preview: Response = .init()
	
	public init(stopId: String) {
		self.stopId = stopId
	}
}

extension BusesRequest {
	public struct Response: Decodable {
		
	}
}
