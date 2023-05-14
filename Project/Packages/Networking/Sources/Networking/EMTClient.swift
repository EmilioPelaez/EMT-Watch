//
//  Created by Emilio Peláez on 12/5/23.
//

import Foundation
import Monarch

public class EMTClient: NetworkProvider {
	public var baseURL: URL = {
		guard let url = URL(string: "https://www.emtvalencia.es") else {
			fatalError("Unable to create startup URL")
		}
		return url
	}()
	
	public init() {}
	
	public func configureURLRequest(_ urlRequest: inout URLRequest) throws {
		urlRequest.addValue("EMTValencia/4.0 (iPhone; iOS 16.4.1; Scale/3.00)", forHTTPHeaderField: "User-Agent")
	}
}
