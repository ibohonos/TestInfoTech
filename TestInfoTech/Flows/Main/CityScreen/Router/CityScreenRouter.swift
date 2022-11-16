//
//  CityScreenRouter.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import Foundation
import UIKit

protocol CityScreenRouter: UIViewControllerPresentation {
}

extension CityScreenViewController: CityScreenRouter, BaseView {
}
