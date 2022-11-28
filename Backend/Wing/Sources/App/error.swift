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
    case promptNotFound
    case profileNotFound
    case nilId
}

extension Error: AbortError {
    var reason: String {
        switch self {
        case .userNotFound:
            return "No user record found."
        case .promptNotFound:
            return "No prompt record found."
        case .profileNotFound:
            return "No profile found."
        case .nilId:
            return "Illegal nil ID."
        }
    }
    var status: HTTPStatus {
        switch self {
        case .userNotFound:
            return .notFound
        case .promptNotFound:
            return .notFound
        case .profileNotFound:
            return .notFound
        case .nilId:
            return .notFound
        }
    }
}

