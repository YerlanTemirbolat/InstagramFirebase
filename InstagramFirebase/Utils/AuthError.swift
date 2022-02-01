//
//  AuthError.swift
//  InstagramFirebase
//
//  Created by Yerlan on 31.01.2022.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case unknownError
    case serverError
    case photoNotExist
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Please confirm all fill", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Email is not valid ", comment: "")
        case .unknownError:
            return NSLocalizedString("Not found", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Photo does not found", comment: "")
        }
    }
}
