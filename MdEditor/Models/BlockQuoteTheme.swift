//
//  BlockQuoteTheme.swift
//  MdEditor
//
//  Created by Zack Williams on 13-11-2026.
//

import MarkdownView

enum BlockQuoteTheme: String, Codable, CaseIterable, Identifiable {
    case `default`
    case github = "GitHub"

    var id: Self { self }
}

extension BlockQuoteTheme {
    var style: any MarkdownBlockQuoteStyle {
        switch self {
        case .default:
            return .default
        case .github:
            return .github
        }
    }
}
