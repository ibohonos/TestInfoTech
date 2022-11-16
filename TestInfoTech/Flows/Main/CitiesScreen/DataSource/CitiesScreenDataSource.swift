//
//  CitiesScreenDataSource.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation

protocol CitiesScreenDataSourceDelegate: AnyObject {
    func didGetError(message: String?)
    func didGetCities(cities: [City])
}

final class CitiesScreenDataSource {
    // MARK: - Properties
    weak var delegate: CitiesScreenDataSourceDelegate?
    
    // MARK: - Init
    init(delegate: CitiesScreenDataSourceDelegate) {
        self.delegate = delegate
    }
    
    func getCities() {
        do {
            let cities = try loadCities()
            
            delegate?.didGetCities(cities: cities)
        } catch {
            delegate?.didGetError(message: error.localizedDescription)
        }
    }
}

// MARK: - Private
private extension CitiesScreenDataSource {
    func loadCities() throws -> [City] {
        if let url = Bundle.main.url(forResource: "city_list", withExtension: "json") {
            let data = try Data(contentsOf: url)

            return try JSONDecoder().decode([City].self, from: data)
        }
        
        return []
    }
}
