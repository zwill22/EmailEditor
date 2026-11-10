//
//  Template.swift
//  MdEditor
//
//  Created by Zack Williams on 29-10-2026.
//

import Foundation
import SwiftData

@Model
class Template {
    var name: String
    var path: String
    var contents: String

    var variables: Set<String>

    func fill(values: [String: String]) throws -> String {
        var keys: Set<String> = []

        print(variables)
        var output = contents

        for (k, v) in values {
            if !variables.contains(k) {
                throw EditorError.invalidTemplateKey(key: k)
            }

            keys.insert(k)

            output.replace("{{\(k)}}", with: v)
        }

        for k in variables {
            if !keys.contains(k) {
                throw EditorError.missingTemplateKey(key: k)
            }
        }

        return output
    }

    init(path: String) throws {
        self.path = path

        let url = URL(filePath: path)

        let filename = url.lastPathComponent
        if filename.isEmpty {
            throw EditorError.invalidFilename
        }

        self.name = String(filename.split(separator: ".")[0]).capitalized(
            with: .current
        )

        let data = try Data(contentsOf: url)

        guard let contentStr = String(data: data, encoding: .utf8) else {
            throw EditorError.fileEncodingError
        }

        self.contents = contentStr

        let templateRegex = Regex(pattern: #"\{\{(\w+)\}\}"#)

        self.variables = templateRegex.extractAll(inputString: contentStr)
    }
}
