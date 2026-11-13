//
//  CodeTheme.swift
//  MdEditor
//
//  Created by Zack Williams on 13-11-2026.
//

enum CodeTheme: String, Codable, CaseIterable, Identifiable {
    case atom = "Atom-One"
    case equilibrium
    case github = "GitHub"
    case google
    case heetch
    case horizon
    case humanoid
    case papercolour
    case paraiso
    case qtcreator
    case silk
    case solarFlare = "Solar-Flare"
    case solarised
    case stackOverflow = "Stack Overflow"
    case tokyoNight = "Tokyo Night"
    case windows10 = "Windows 10"
    case xcode = "XCode"

    var id: Self { self }
}

extension CodeTheme {
    var lightTheme: String {
        switch self {
        case .atom:
            return "atom-one-light"
        case .equilibrium:
            return "equilibrium-light"
        case .github:
            return "github"
        case .google:
            return "google-light"
        case .heetch:
            return "heetch-light"
        case .horizon:
            return "horizon-light"
        case .humanoid:
            return "humanoid-light"
        case .papercolour:
            return "papercolor-light"
        case .paraiso:
            return "paraiso-light"
        case .qtcreator:
            return "qtcreator-light"
        case .silk:
            return "silk-light"
        case .solarFlare:
            return "solar-flare-light"
        case .solarised:
            return "solarized-light"
        case .stackOverflow:
            return "stackoverflow-light"
        case .tokyoNight:
            return "tokyo-night-light"
        case .windows10:
            return "windows-10-light"
        case .xcode:
            return "xcode"
        }
    }
    var darkTheme: String {
        switch self {
        case .atom:
            return "atom-one-dark"
        case .equilibrium:
            return "equilibrium-dark"
        case .github:
            return "github-dark"
        case .google:
            return "google-dark"
        case .heetch:
            return "heetch-dark"
        case .horizon:
            return "horizon-dark"
        case .humanoid:
            return "humanoid-dark"
        case .papercolour:
            return "papercolor-dark"
        case .paraiso:
            return "paraiso-dark"
        case .qtcreator:
            return "qtcreator-dark"
        case .silk:
            return "silk-dark"
        case .solarFlare:
            return "solar-flare"
        case .solarised:
            return "solarized-dark"
        case .stackOverflow:
            return "stackoverflow-dark"
        case .tokyoNight:
            return "tokyo-night-dark"
        case .windows10:
            return "windows-10"
        case .xcode:
            return "xcode-dark"
        }
    }
}
