//
//  SignInModel.swift
//  swe-project-app
//
//  Created by Hugh Do on 11/10/20.
//

import Foundation

class SignInModel {
    
    var email = ""
    var password = ""
    
    func validPassword() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func validEmail() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
}

