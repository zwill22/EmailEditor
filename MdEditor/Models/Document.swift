//
//  Document.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import Foundation
import SwiftData

func toText<StringType>(markdown: StringType) -> String
where StringType: StringProtocol {
    guard let attributed = try? AttributedString(markdown: String(markdown))
    else {
        return String(markdown)
    }

    // Extract raw string
    return String(attributed.characters)
}

@Model
class Document {
    var content: String
    var timestamp: Date

    var addresses: [Address]
    var subject: String

    var start: String {
        let textRegex = Regex(pattern: ##"^([^#\n_>!`\*].+)$"##)

        if let groups = textRegex.extractFirst(inputString: content) {
            return toText(markdown: groups[0])
        }

        if let substring = content.split(
            maxSplits: 1,
            whereSeparator: \.isNewline
        ).first {
            return toText(markdown: substring)
        }

        return "Empty document"
    }

    var title: String {
        let titleRegex = Regex(pattern: ##"^# (.+)$"##)

        if let groups = titleRegex.extractFirst(inputString: content) {
            return toText(markdown: groups[0])
        } else if !subject.isEmpty {
            return subject
        } else {
            return start
        }
    }

    func asHtml() -> String {
        var generator = HtmlGenerator()

        return generator.toHtml(markdown: content)
    }

    func getPreview(include: Bool, text: String) -> String {
        let preview = include ? text : ""

        if preview.isEmpty {
            return self.start
        }

        return preview
    }

    init(
        content: String = "",
        addresses: [String] = [],
        subject: String = "",
        timestamp: Date = .now
    ) {
        self.content = content
        self.addresses = addresses.map({ address in
            Address(address: address)
        })
        self.subject = subject
        self.timestamp = timestamp
    }
}
