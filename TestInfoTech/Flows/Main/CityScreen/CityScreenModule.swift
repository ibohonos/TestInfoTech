//
//  CityScreenModule.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation
import UIKit

final class CityScreenModule: ModuleInitializable {
    // MARK: - Properties
    private let view: CityScreenViewController
    private let presenter: CityScreenPresenter

    // MARK: - Init / Deinit methods
    init() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        view = storyboard.instantiateViewController(withIdentifier: "CityScreenViewController") as! CityScreenViewController
        presenter = CityScreenPresenter(with: view, router: view)
        view.presenter = presenter
    }
    
    convenience init(city: City) {
        self.init()
        view.setCity(city)
    }

    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
