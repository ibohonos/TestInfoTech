//
//  CityScreenDataSource.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation

protocol CityScreenDataSourceDelegate: AnyObject {
    func didGetError(message: String?)
    func didGetWeather(response: WeatherResponse)
}

final class CityScreenDataSource {
    // MARK: - Properties
    weak var delegate: CityScreenDataSourceDelegate?
    
    // MARK: - Init
    init(delegate: CityScreenDataSourceDelegate) {
        self.delegate = delegate
    }
    
    func getWeather(coordinate: CityCoordinate) {
        let request = GetCityWeatherRequest(coordinate: coordinate)
        
        NetworkManager.shared.perform(request: request) { [weak self] data, networkError in
            if let networkError {
                let message = networkError.errors ?? networkError.message
                self?.delegate?.didGetError(message: message)
                return
            }

            guard let dataObj = data else {
                self?.delegate?.didGetError(message: "Data object is missing")
                return
            }

            do {
                let response = try JSONDecoder().decode(WeatherResponse.self, from: dataObj)
                self?.delegate?.didGetWeather(response: response)
            } catch {
                self?.delegate?.didGetError(message: error.localizedDescription)
            }
        }
    }
}
