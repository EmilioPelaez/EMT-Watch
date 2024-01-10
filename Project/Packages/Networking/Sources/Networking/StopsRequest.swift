//
//  Created by Emilio Peláez on 12/5/23.
//

import Model
import Monarch

public struct StopsRequest: RemoteRequest {
	public let path: String = "opentripplanner-api-webapp/ws/metadata/stopsInExtent"
	public var query: [String: Any] = [
		"lowerCornerLat": 38.460022,
		"lowerCornerLon": -1.366823,
		"upperCornerLat": 40.480022,
		"upperCornerLon": 0.386823,
	]
	
	public let preview: Response = .init(stop: [])
	
	public init() {}
}

extension StopsRequest {
	public struct Response: Decodable {
		var stop: [Stop]
		
		public struct Stop: Decodable {
			enum CodingKeys: String, CodingKey {
				case lat, lon, name, routes, stopID = "stopId",ubica
			}
			
			let lat, lon, name, stopID, ubica: String
			let routes: RoutesContainer
			
			public struct RoutesContainer: Codable {
				let rtI: Routes
			}
			
			enum Routes: Codable {
				case single(Route)
				case multiple([Route])
				
				init(from decoder: Decoder) throws {
					let container = try decoder.singleValueContainer()
					if let x = try? container.decode([Route].self) {
						self = .multiple(x)
						return
					}
					if let x = try? container.decode(Route.self) {
						self = .single(x)
						return
					}
					throw DecodingError.typeMismatch(Routes.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RtIUnion"))
				}
				
				func encode(to encoder: Encoder) throws {
					var container = encoder.singleValueContainer()
					switch self {
					case .single(let x):
						try container.encode(x)
					case .multiple(let x):
						try container.encode(x)
					}
				}
				
				var array: [Route] {
					switch self {
					case .single(let route): return [route]
					case .multiple(let routes): return routes
					}
				}
			}
			
			struct Route: Codable {
				let headSign, idLinea, ln, sn: String
				
				enum CodingKeys: String, CodingKey {
					case headSign
					case idLinea = "id_linea"
					case ln = "LN"
					case sn = "SN"
				}
			}
		}
	}
}

extension StopsRequest.Response.Stop {
	var stop: Model.Stop {
		.init(id: stopID,
					name: name,
					address: ubica,
					coordinate: .init(latitude: Double(lat) ?? 0, longitude: Double(lon) ?? 0),
					lines: routes.rtI.array.map(\.linea))
	}
}

extension StopsRequest.Response.Stop.Route {
	var linea: Line {
		.init(lineNumber: idLinea, destination: headSign)
	}
}
