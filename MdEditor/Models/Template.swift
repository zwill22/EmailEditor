//
//  Template.swift
//  MdEditor
//
//  Created by Zack Williams on 29-10-2026.
//

import Foundation
import SwiftData

enum TemplateError: Error {
    case invalidEncoding
    case emptyPath
    case unexpectedError(error: Error)
}

extension TemplateError: LocalizedError {

}

@Model
class Template {
    var name: String
    var path: String
    var contents: String

    var variables: Set<String>

    init(path: String) throws {
        self.path = path

        let url = URL(filePath: path)

        let filename = url.lastPathComponent
        if filename.isEmpty {
            throw TemplateError.emptyPath
        }

        self.name = String(filename.split(separator: ".")[0]).capitalized(
            with: .current
        )

        let data = try Data(contentsOf: url)

        guard let contentStr = String(data: data, encoding: .utf8) else {
            throw TemplateError.invalidEncoding
        }

        self.contents = contentStr

        let templateRegex = Regex(pattern: #"\{\{(\w+)\}\}"#)

        self.variables = templateRegex.extractAll(inputString: contentStr)
    }
}
