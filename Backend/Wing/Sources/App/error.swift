//
//  Error.swift
//  Custom API Error for Routes 
//
//  Created by Allie Griffin on 2022-11-27.
//

import Foundation
import Vapor


//Wrap Abort Error to Generate Custom HTTP Errors
enum Error {
    case userNotFound
    case notFoundwID(String, UUID)
    case promptNotFound
    case profileNotFound
    case nilId
    case dupVal(String, String)
    case nilIndex
    case photoNotFoundwIndex
}

extension Error: AbortError {
    var reason: String {
        switch self {
        case .userNotFound:
            return "No user record found."
        case .notFoundwID(let type, let id):
            return "No \(type) record found with ID: \(id)."
        case .promptNotFound:
            return "No prompt record found."
        case .profileNotFound:
            return "No profile found."
        case .nilId:
            return "Illegal nil ID."
        case .dupVal(let field, let val):
            return "Illegal \(field) value: \(val)."
        case .nilIndex:
            return "No photo for user with given index."
        case .photoNotFoundwIndex:
            return "No photo record found."
            
        }
    }
    var status: HTTPStatus {
        switch self {
        case .userNotFound:
            return .notFound
        case .notFoundwID:
            return .notFound
        case .promptNotFound:
            return .notFound
        case .profileNotFound:
            return .notFound
        case .nilId:
            return .notFound
        case .dupVal:
            return .internalServerError
        case .nilIndex:
            return .notFound
        case .photoNotFoundwIndex:
            return .notFound
        }
    }
}

