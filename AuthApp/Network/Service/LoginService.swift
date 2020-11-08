//
//  LoginService.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 03/11/2020.
//

import Foundation
import Alamofire
import SwiftyJSON
import FirebaseAuth

enum FirebaseResponse {
    case success(String)
    case failure(FirebaseRequestError)
}

enum FirebaseRequestError: Error {
    case unknownError
    case connectionError
    case operationNotAllowed
    case invalidRequest
    case invalidResponse
    case serverError
    case serverUnavailable
    case userDisabled
    case wrongPassword
    case invalidEmail
    case userNotFound
}

class LoginService {
    
    
    // MARK: - Private Properties
    private let apiManager: ApiManager
    
    // MARK: - Designated Initializer
    
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
}



extension LoginService {
    
    func login(email: String, password: String, completion: @escaping (FirebaseResponse)-> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            
            if let error = error as? NSError {
                
                switch AuthErrorCode(rawValue: error.code) {
                
                case .operationNotAllowed:
                    completion(FirebaseResponse.failure(.operationNotAllowed))
                case .userDisabled:
                    completion(FirebaseResponse.failure(.userDisabled))
                case .wrongPassword:
                    
                    completion(FirebaseResponse.failure(.wrongPassword))
                case .invalidEmail:
                    completion(FirebaseResponse.failure(.invalidEmail))
                case .userNotFound:
                    completion(FirebaseResponse.failure(.userNotFound))
                default:
                    print("Errorrl :\(error.code)")
                    print("Error: \(error.localizedDescription)")
                    completion(FirebaseResponse.failure(.unknownError))
                }
            } else {
                
                let userInfo = Auth.auth().currentUser
                let email = userInfo?.email
                completion(FirebaseResponse.success(email ?? "Could not retrieve user email."))
            }
        }
    }
    
}
