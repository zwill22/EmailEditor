//
//  AppColourScheme.swift
//  MdEditor
//
//  Created by Zack Williams on 13-11-2026.
//

import SwiftUI

enum AppColourScheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: Self { self }
}

extension AppColourScheme {
    func resolve() -> ColorScheme? {
        switch self {
        case .system:
            return .none
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
