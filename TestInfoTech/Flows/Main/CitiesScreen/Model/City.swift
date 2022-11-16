//
//  City.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation

struct City: Identifiable, Codable {
    let id: Int
    
    let name: String
    let state: String?
    let country: String
    let coord: CityCoordinate
}

struct CityCoordinate: Codable {
    let lon: Double
    let lat: Double
}
