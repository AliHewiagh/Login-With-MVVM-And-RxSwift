//
//  ApiResponse.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 03/11/2020.
//

import Foundation
import SwiftyJSON

enum ApiResponse {
    case success(JSON)
    case failure(RequestError)
}
