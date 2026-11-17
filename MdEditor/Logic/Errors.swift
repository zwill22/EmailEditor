//
//  Errors.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import Foundation

extension Error {
    var localisedDescription: String {
        return self.localizedDescription
    }
}

protocol LocalisedError: LocalizedError {}

func localisedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
