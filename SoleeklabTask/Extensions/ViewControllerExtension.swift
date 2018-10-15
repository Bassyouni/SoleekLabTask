//
//  ViewControllerExtension.swift
//  SoleeklabTask
//
//  Created by MacBook Pro on 10/15/18.
//  Copyright © 2018 Bassyouni. All rights reserved.
//

import Foundation



extension UIViewController
{
    func showErrorAlert(message: String)
    {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
