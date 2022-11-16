//
//  CitiesScreenPresenter.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation

protocol CitiesScreenPresenterProtocol: AnyObject {
    func neededToLoadCities()
    func neededToSearchCities(text: String?)
    func neededToShowCityScreen(_ city: City)
}

final class CitiesScreenPresenter {
    // MARK: - Properties
    private weak var view: CitiesScreenViewControllerProtocol?
    private weak var router: CitiesScreenRouter?
    private(set) var data: CitiesScreenDataSource!
    private var cities: [City] = []
    
    // MARK: - Init / Deinit methods
    init(with view: CitiesScreenViewControllerProtocol, router: CitiesScreenRouter) {
        self.view = view
        self.router = router
        self.data = CitiesScreenDataSource(delegate: self)
    }
}

// MARK: - CitiesScreenPresenterProtocol
extension CitiesScreenPresenter: CitiesScreenPresenterProtocol {
    func neededToLoadCities() {
        data.getCities()
    }
    
    func neededToSearchCities(text: String?) {
        if let text, !text.isEmpty {
            let test = cities.filter({ $0.name.lowercased().contains(text.lowercased()) })
            view?.didGetCities(cities: test)
            return
        }
        
        view?.didGetCities(cities: cities)
    }
    
    func neededToShowCityScreen(_ city: City) {
        router?.showCityScreen(city)
    }
}

// MARK: - CitiesScreenDataSourceDelegate
extension CitiesScreenPresenter: CitiesScreenDataSourceDelegate {
    func didGetError(message: String?) {
        view?.didGetError(message: message)
    }
    
    func didGetCities(cities: [City]) {
        self.cities = cities
        view?.didGetCities(cities: cities)
    }
}
