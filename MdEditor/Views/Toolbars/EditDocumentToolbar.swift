//
//  EditDocumentToolbar.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import SwiftData
import SwiftUI

struct EditDocumentToolbar: ToolbarContent {
    var document: MarkdownDocument
    @Binding var editing: Bool

    @Binding var content: String
    @Binding var location: URL?
    @Binding var errorHandler: ErrorHandler

    @Environment(DataContainer.self) private var dataContainer

    private func update() throws {
        document.content = content
        document.location = location
        document.timestamp = .now

        dataContainer.context.insert(document)

        try dataContainer.context.save()

    }

    private func unchanged() -> Bool {
        return content == document.content
    }

    private func dismiss() {
        editing = false
    }

    var body: some ToolbarContent {
        EditingToolbar(
            dismiss: dismiss,
            unchanged: unchanged,
            update: update,
            errorHandler: $errorHandler
        )
    }
}
