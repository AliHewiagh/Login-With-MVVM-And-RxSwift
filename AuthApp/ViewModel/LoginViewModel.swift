//
//  LoginViewModel.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 27/10/2020.
//

import Foundation
import RxSwift
import RxCocoa


class LoginViewModel {
    
    // MARK: - Properties
    let loginService: LoginService
    
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let isValid: Observable<Bool>
    let showLoading = BehaviorRelay<Bool>(value: false)
    
    
    public let successLogin : PublishSubject<SuccessLogin> = PublishSubject()
    
    public let error : PublishSubject<DisplayError> = PublishSubject()
    
    
    // MARK: - init
    init(loginService: LoginService = LoginService(apiManager: ApiManager())) {
        
        isValid = Observable.combineLatest(self.email.asObservable(), self.password.asObservable())
        { (email, password) in
            return email.isValidEmail()
                && password.isValidPassword()
        }
        self.loginService = loginService
    }
}

extension LoginViewModel {
    
    func login(email: String, password: String) {
        
        self.showLoading.accept(true)
        
        self.loginService.login(email: email, password: password, completion: {(result) in
            self.showLoading.accept(false)
            switch result {
            case .success(let data) :
                self.successLogin.onNext(.redirectToHome(data))
            case .failure(let failure) :
                switch failure {
                case .invalidEmail:
                    self.error.onNext(.serverMessage("Invalid Email."))
                case .userNotFound:
                    self.error.onNext(.serverMessage("User Not Found."))
                case .userDisabled:
                    self.error.onNext(.serverMessage("Account Disabled."))
                case .wrongPassword:
                    self.error.onNext(.serverMessage("Wrong Password."))
                case .operationNotAllowed:
                self.error.onNext(.serverMessage("Operation Not Allowed."))
                default:
                    self.error.onNext(.serverMessage("Unkown Error."))
                    print("Unkown Error.")
                }
            }
        })
    }
}


