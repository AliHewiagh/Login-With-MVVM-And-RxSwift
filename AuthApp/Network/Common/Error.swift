//
//  Error.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 03/11/2020.
//

import Foundation
import SwiftyJSON

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError(JSON)
    case invalidRequest
    case invalidResponse
    case serverError
    case serverUnavailable
}


public enum DisplayError: Equatable {
    case internetError(String)
    case serverMessage(String)
}


public enum SuccessLogin: Equatable {
    case redirectToHome(String)
}
