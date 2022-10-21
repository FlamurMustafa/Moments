//
//  UIViewController.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import UIKit
extension UIViewController{
    // Alert
    func showErro(_ title: String?, message: String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "ok", style: .default,
                                     handler:nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}
