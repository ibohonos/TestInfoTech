//
//  CitiesScreenModule.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation
import UIKit

final class CitiesScreenModule: ModuleInitializable {
    // MARK: - Properties
    private let view: CitiesScreenViewController
    private let presenter: CitiesScreenPresenter

    // MARK: - Init / Deinit methods
    init() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        view = storyboard.instantiateViewController(withIdentifier: "CitiesScreenViewController") as! CitiesScreenViewController
        presenter = CitiesScreenPresenter(with: view, router: view)
        view.presenter = presenter
    }

    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
