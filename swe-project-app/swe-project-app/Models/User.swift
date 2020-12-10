//
//  User.swift
//  String
//
//  Created by Justin Schwartz on 9/12/20.
//

import Foundation

class User: Codable {
    var uid: String
    var email: String
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
