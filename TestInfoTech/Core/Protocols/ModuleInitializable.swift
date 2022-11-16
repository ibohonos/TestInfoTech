//
//  ModuleInitializable.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import UIKit

public protocol BaseModule {
    func viewController() -> UIViewController
}

typealias ModuleInitializable = BaseModule & Initializable

protocol Initializable {
    init()
}

extension Initializable {
    static var stringValue: String {
        return String(describing: self)
    }
}
