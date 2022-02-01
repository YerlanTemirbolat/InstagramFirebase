//
//  Validators.swift
//  InstagramFirebase
//
//  Created by Yerlan on 31.01.2022.
//

import Foundation

class Validators {
    
    static func isFilled(email: String?, username: String?, password: String?) -> Bool {
        guard !(email ?? "").isEmpty,
              !(username ?? "").isEmpty,
              !(password ?? "").isEmpty else {
                  return false
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return true
    }
    
}
