//s
//  ApiManager.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 03/11/2020.
//

import Foundation
import Alamofire

class ApiManager {
    
    var commenHeaders: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]


    // Common Function For API Requests
    func apiRequest(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeader?, completion: @escaping (DataResponse<Any, AFError>)->Void ) {
        
        if let extraHeaders = headers {
            commenHeaders.add(extraHeaders)
        }
        
        AF.request(url, method: method, parameters: parameters, headers: commenHeaders).validate(statusCode: 200...299).responseJSON() { response in
            
            print("Type of \(type(of: response))")
            completion(response)

        }
    }
}
