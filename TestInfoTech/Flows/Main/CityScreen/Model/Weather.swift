//
//  Weather.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation

struct WeatherResponse: Identifiable, Codable {
    let id: Int

    let name: String
    let weather: [Weather]
    let main: WeatherMain
    let wind: Wind
}

struct Weather: Identifiable, Codable {
    let id: Int

    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Wind: Codable {
    let speed: Double
}
