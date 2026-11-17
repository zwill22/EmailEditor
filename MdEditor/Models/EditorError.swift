//
//  EditorError.swift
//  MdEditor
//
//  Created by Zack Williams on 03-11-2026.
//

import Foundation

enum EditorError: Error {
    case fileEncodingError
    case fileReadError(filename: String)
    case fileWriteError(error: Error)
    case invalidFilename
    case invalidEmailAccount(name: String)
    case invalidTemplateKey(key: String)
    case missingTemplateKey(key: String)
    case noFileLocation
    case unexpectedError(error: Error)
}

extension EditorError: LocalisedError {
    var errorDescription: String? {
        switch self {
        case .fileEncodingError:
            return localisedString(
                "Unable to decode file data with UTF-8 encoding"
            )
        case .fileReadError(let filename):
            return localisedString(
                "Unable to read file \(filename)"
            )
        case .fileWriteError(let error):
            return localisedString(
                "Unable to write file: \(error.localisedDescription)"
            )
        case .invalidFilename:
            return localisedString(
                "Invalid filename provided"
            )
        case .invalidEmailAccount(let name):
            return localisedString(
                "Invalid configuration for account: \(name)"
            )
        case .invalidTemplateKey(let key):
            return localisedString(
                "Invalid template key: \(key)"
            )
        case .missingTemplateKey(let key):
            return localisedString(
                "No information provided for template key: \(key)"
            )
        case .noFileLocation:
            return localisedString("No file location specified")
        case .unexpectedError(let error):
            return localisedString(
                "Received unexpected error: \(error.localisedDescription)"
            )
        }
    }
}
