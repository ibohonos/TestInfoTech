//
//  UIViewController+Universal.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 16.11.2022.
//

import UIKit

// MARK: - Alerts presenter
public extension UIViewController {
    func presentError(message: String?, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: completion)
    }
    
    func presentAlert(title: String, message: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
