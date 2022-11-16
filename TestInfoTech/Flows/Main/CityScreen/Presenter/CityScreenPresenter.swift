//
//  CityScreenPresenter.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation

protocol CityScreenPresenterProtocol: AnyObject {
    func neededLoadWeather(coordinate: CityCoordinate)
}

final class CityScreenPresenter {
    // MARK: - Properties
    private weak var view: CityScreenViewControllerProtocol?
    private weak var router: CityScreenRouter?
    private(set) var data: CityScreenDataSource!
    
    // MARK: - Init / Deinit methods
    init(with view: CityScreenViewControllerProtocol, router: CityScreenRouter) {
        self.view = view
        self.router = router
        self.data = CityScreenDataSource(delegate: self)
    }
}

// MARK: - CityScreenPresenterProtocol
extension CityScreenPresenter: CityScreenPresenterProtocol {
    func neededLoadWeather(coordinate: CityCoordinate) {
        data.getWeather(coordinate: coordinate)
    }
}

// MARK: - CityScreenDataSourceDelegate
extension CityScreenPresenter: CityScreenDataSourceDelegate {
    func didGetError(message: String?) {
        view?.didGetError(message: message)
    }
    
    func didGetWeather(response: WeatherResponse) {
        view?.didGetWeather(response: response)
    }
}
