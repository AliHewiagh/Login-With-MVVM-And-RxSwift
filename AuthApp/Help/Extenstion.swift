//
//  Extenstion.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 08/11/2020.
//

import UIKit
import RxCocoa
import RxSwift

protocol loadingViewable {
    func startAnimating()
    func stopAnimating()
}

extension String {
    // Used to validate if the given string is valid email or not
   
    // - Returns: Boolean indicating if the string is valid email or not
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        print("emailTest.evaluate(with: self): \(emailTest.evaluate(with: self))")
        return emailTest.evaluate(with: self)
    }
    
    // Used to validate if the given string matches the password requirements
   
    // - Returns: Boolean indicating the comparison result
    func isValidPassword() -> Bool {
//        print("self.count >= 6: \(self.count >= 6)")
        return self.count >= 6
    }
}




extension UIViewController: loadingViewable {}

extension Reactive where Base: UIViewController {
    
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
}




extension loadingViewable where Self : UIViewController {
    func startAnimating(){
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        view.addSubview(spinner)
        spinner.restorationIdentifier = "loadingIndicator"
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.bringSubviewToFront(spinner)
    }
    func stopAnimating() {
        for item in view.subviews
            where item.restorationIdentifier == "loadingIndicator" {
                UIView.animate(withDuration: 0.3, animations: {
                    item.alpha = 0
                }) { (_) in
                    item.removeFromSuperview()
                }
        }
    }
}
