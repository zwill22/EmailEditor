//
//  EditorError.swift
//  MdEditor
//
//  Created by Zack Williams on 03-11-2026.
//

import Foundation

enum EditorError: Error {
    case fileEncodingError(filename: String)
    case fileReadError(filename: String)
    case fileWriteError(filename: String)
    case serverConnectionError(server: String, port: Int)
    case serverLoginError(name: String)
    case unexpectedError(error: Error)
}

extension EditorError: LocalisedError {
    var errorDescription: String? {
        switch self {
        case .fileEncodingError(let filename):
            return localisedString(
                "Invalid encoding for file, unable to decode: \(filename)"
            )
        case .fileReadError(let filename):
            return localisedString(
                "Error reading file: \(filename)"
            )
        case .fileWriteError(let filename):
            return localisedString(
                "Error writing to file: \(filename)"
            )
        case .serverConnectionError(let server, let port):
            return localisedString(
                "Unable to connect with email server: \(server):\(port)"
            )
        case .serverLoginError(let name):
            return localisedString(
                "Unable to login to server \(name), please check your credentials"
            )
        case .unexpectedError(let error):
            return localisedString(
                "Received unexpected error: \(error.localisedDescription)"
            )
        }
    }
}
