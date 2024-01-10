//
//  Created by Emilio Peláez on 12/5/23.
//

import Foundation
import Model
import Monarch
import XMLCoder

struct BusesRequest: RemoteRequest {
	let stopId: String
	
	var path: String = "EMT/mapfunctions/MapUtilsPetitions.php"
	var query: [String: Any] {
		[
			"parada": stopId,
			"sec": "getSAE",
			"idioma": "en",
			"adaptados": false,
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
				let minutos: String?
				let horaLlegada: String?
				
				var isValid: Bool {
					!linea.isEmpty
						&& !destino.isEmpty
						&& !(minutos ?? horaLlegada ?? "").isEmpty
				}
			}
		}
	}
}

extension BusesRequest.Response.Parada.Bus {
	var bus: Model.Bus {
		let eta: Model.Bus.ETA = {
			if let minutos, !minutos.isEmpty {
				return Bus.ETA(minutos)
			} else if let horaLlegada, !horaLlegada.isEmpty {
				return Bus.ETA(horaLlegada)
			} else {
				return Bus.ETA.unknown
			}
		}()
		return Model.Bus(linea: linea, destination: destino, eta: eta)
	}
}

extension Bus.ETA {
	init(_ string: String) {
		if string == "Next" {
			self = .next
		} else if string.contains(" min.") {
			let trimmed = string.replacingOccurrences(of: " min.", with: "")
			if let value = Int(trimmed) {
				self = .minutes(value)
			} else {
				self = .unknown
			}
		} else if string.contains(":") {
			self = .time(string)
		} else {
			self = .unknown
		}
	}
}
