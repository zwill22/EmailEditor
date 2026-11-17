//
//  NewDocumentToolbar.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import SwiftData
import SwiftUI

struct NewDocumentToolbar: ToolbarContent {
    @Binding var showing: Bool
    @Binding var newDocument: MarkdownDocument

    @Binding var errorHandler: ErrorHandler

    @Environment(DataContainer.self) private var dataContainer

    private func dismiss() {
        showing = false
    }

    private func unchanged() -> Bool {
        return newDocument.content.isEmpty
    }

    private func update() throws {
        newDocument.timestamp = .now

        dataContainer.context.insert(newDocument)

        try dataContainer.context.save()

        dismiss()
    }

    private func disableSave() -> Bool {
        return newDocument.content.isEmpty
    }

    private var exportButton: some View {
        ExportButton(document: $newDocument, errorHandler: $errorHandler)
    }

    private var cancelButton: some View {
        CancelButton(dismiss: dismiss, unchanged: unchanged)
    }

    private var saveButton: some View {
        SaveButton(
            dismiss: dismiss,
            unchanged: unchanged,
            update: update,
            disableSaveButton: disableSave,
            errorHandler: $errorHandler
        )
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            exportButton
        }

        ToolbarItem(placement: .cancellationAction) {
            cancelButton
        }

        ToolbarItem(placement: .confirmationAction) {
            saveButton
        }
    }
}
