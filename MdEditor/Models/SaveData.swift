//
//  SaveData.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import Foundation

extension MarkdownDocument {
    func save() throws {
        guard let fileUrl = location else {
            throw EditorError.noFileLocation
        }

        do {
            try content.write(to: fileUrl, atomically: true, encoding: .utf8)
        } catch {
            throw EditorError.fileWriteError(error: error)
        }
    }
}
