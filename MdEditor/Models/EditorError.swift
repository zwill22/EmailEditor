//
//  EditorError.swift
//  MdEditor
//
//  Created by Zack Williams on 03-11-2026.
//

import Foundation

enum EditorError: Error {
    case fileEncodingError
    case invalidFilename
    case invalidTemplateKey(key: String)
    case missingTemplateKey(key: String)
    case unexpectedError(error: Error)
}

extension EditorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .fileEncodingError:
            return NSLocalizedString(
                "Unable to decode file data with UTF-8 encoding",
                comment: ""
            )
        case .invalidFilename:
            return NSLocalizedString(
                "Invalid filename provided",
                comment: ""
            )
        case .invalidTemplateKey(key: let key):
            return NSLocalizedString(
                "Invalid template key: \(key)",
                comment: ""
            )
        case .missingTemplateKey(key: let key):
            return NSLocalizedString(
                "No information provided for template key: \(key)",
                comment: ""
            )
        case .unexpectedError(error: let error):
            return NSLocalizedString(
                "Received unexpected error: \(error.localizedDescription)",
                comment: ""
            )
        }
    }
}
