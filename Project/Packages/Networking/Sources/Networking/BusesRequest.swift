//
//  Created by Emilio Peláez on 12/5/23.
//

import Foundation
import Monarch

public struct BusesRequest: Request {
	let stopId: String
	
	public var path: String = "https://www.emtvalencia.es/EMT/mapfunctions/MapUtilsPetitions.php?sec=getSAE&idioma=en&adaptados=false"
	public var query: [String: Any] {
		["parada": stopId]
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
