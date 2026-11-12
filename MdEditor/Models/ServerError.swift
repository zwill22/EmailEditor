//
//  ServerError.swift
//  MdEditor
//
//  Created by Zack Williams on 12-11-2026.
//

import Foundation

enum ServerError: Error {
    case notConnected
    case notLoggedIn
    case loginError(error: Error)
    case unableToConnect(error: Error)
    case unexpectedError(error: Error)
}

extension ServerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notConnected:
            return NSLocalizedString(
                "Not connected to server, run `connect()` method first",
                comment: ""
            )
        case .notLoggedIn:
            return NSLocalizedString(
                "Not logged in to server, run `login()` method first",
                comment: ""
            )
        case .loginError(let error):
            return NSLocalizedString(
                "Unable to login to server: \(error.localizedDescription)",
                comment: ""
            )
        case .unableToConnect(let error):
            return NSLocalizedString(
                "Unable to connect to server: \(error.localizedDescription)",
                comment: ""
            )
        case .unexpectedError(let error):
            return NSLocalizedString(
                "Received unexpected error: \(error.localizedDescription)",
                comment: ""
            )
        }
    }
}
