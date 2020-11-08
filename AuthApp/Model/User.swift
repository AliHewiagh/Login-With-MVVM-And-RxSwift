//
//  User.swift
//  AuthApp
//
//  Created by Ali Hewiagh on 27/10/2020.
//

import UIKit

struct User: Codable, Equatable {
    
    let email, password : String

    enum CodingKeys: String, CodingKey {
            case email
            case password
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
       return true
    }
}

// MARK: Convenience initializers
extension User {
    init?(data: Data) {
        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil }
        self = user
    }
}
