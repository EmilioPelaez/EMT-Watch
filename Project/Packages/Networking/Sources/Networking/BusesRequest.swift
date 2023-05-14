//
//  Created by Emilio Peláez on 12/5/23.
//

import Foundation
import Model
import Monarch
import XMLCoder

struct BusesRequest: Request {
	let stopId: String
	
	var path: String = "EMT/mapfunctions/MapUtilsPetitions.php"
	var query: [String: Any] {
		[
			"parada": stopId,
		 "sec": "getSAE",
		 "idioma": "en",
		 "adaptados": false
		]
	}
	var preview: Response = .init(parada: .init(bus: []))
	
	init(stopId: String) {
		self.stopId = stopId
	}
	
	func decode(_ data: Data) throws -> Response {
		try XMLDecoder().decode(Response.self, from: data)
	}
}

extension BusesRequest {
	struct Response: Decodable {
		var parada: Parada
		
		enum CodingKeys: String, CodingKey {
			case parada = "solo_parada"
		}
		
		struct Parada: Decodable {
			let bus: [Bus]
			
			struct Bus: Decodable {
				let linea: String
				let destino: String
				let minutos: String
			}
		}
	}
}

extension BusesRequest.Response.Parada.Bus {
	var bus: Model.Bus {
		.init(linea: linea, destination: destino, eta: .init(minutos))
	}
}

extension Bus.ETA {
	init(_ string: String) {
		if string == "Next" {
			self = .next
		} else if let trimmed = string.replacingOccurrences(of: " min.", with: "") as? String,
							let value = Int(trimmed) {
			self = .minutes(value)
		} else {
			print("Invalid \(string)")
			self = .unknown
		}
	}
}
