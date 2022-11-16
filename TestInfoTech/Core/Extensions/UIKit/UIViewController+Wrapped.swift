//
//  UIViewController+Wrapped.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import UIKit.UIViewController

extension UIViewController {
    var wrapped: UINavigationController {
        let wrappedViewController = UINavigationController(rootViewController: self)

        return wrappedViewController
    }
}
