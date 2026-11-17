//
//  SaveDocument.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import SwiftUI
import UniformTypeIdentifiers

extension MarkdownDocument: Document {

    static var readableContentTypes: [UTType] {
        [.markdown]
    }

    func reader(configuration: sending ReadConfiguration)
        -> sending FileWrapperDocumentReader<String>
    {
        FileWrapperDocumentReader(configuration) { fileWrapper in
            guard
                let data =
                    fileWrapper.regularFileContents
            else {
                throw EditorError.fileReadError(
                    filename: fileWrapper.filename ?? ""
                )
            }
            return String(decoding: data, as: UTF8.self)
        }
    }

    func writer(configuration: sending WriteConfiguration)
        -> sending FileWrapperDocumentWriter<String>
    {
        FileWrapperDocumentWriter(configuration) { snapshot, _ in
            FileWrapper(
                regularFileWithContents: Data(snapshot.utf8)
            )
        }
    }

    @MainActor
    func snapshot(contentType: UTType) async throws -> sending String {
        content
    }

    @MainActor
    func apply(snapshot: sending String, previous: sending String?) async throws
    {
        content = snapshot
    }

}
