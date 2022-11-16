//
//  GetCityWeatherRequest.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation

// MARK: - GetCityWeatherRequest
struct GetCityWeatherRequest: BaseRequest {
    var path: String = "/data/2.5/weather"
    var method: HTTPMethod = .get
    var params: [String: Any]?
    var headers: [String: String]?
    
    init(coordinate: CityCoordinate) {
        params = [
            "lat": coordinate.lat,
            "lon": coordinate.lon,
            "appid": "1e1566d689d9b3288f56bb8c53b7ccfc",
            "units": "metric",
//            "lang": "ua"
        ]
    }
}
