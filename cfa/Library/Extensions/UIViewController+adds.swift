//
//  UIViewController+adds.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 12.03.2021.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardView() {
        view.endEditing(true)
    }
}
