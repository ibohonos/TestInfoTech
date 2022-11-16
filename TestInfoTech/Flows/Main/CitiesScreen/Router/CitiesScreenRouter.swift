//
//  CitiesScreenRouter.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation
import UIKit

protocol CitiesScreenRouter: UIViewControllerPresentation {
    func showCityScreen(_ city: City)
}

extension CitiesScreenViewController: CitiesScreenRouter, BaseView {
    func showCityScreen(_ city: City) {
        push(module: CityScreenModule(city: city))
    }
}
