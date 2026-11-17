//
//  DocumentDetailToolbar.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import SwiftData
import SwiftUI

struct DocumentDetailToolbar: ToolbarContent {
    @State private var showConfirmation = false

    var document: MarkdownDocument
    @Binding var editMode: Bool
    @Binding var showSidebar: Bool
    @Binding var showSendMenu: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    private var editButton: some View {
        Button("Edit", systemImage: "pencil") {
            editMode = true
            showSidebar = false
        }
    }

    private func delete() {
        dataContainer.context.delete(document)
        try? dataContainer.context.save()
        dismiss()
    }

    private var deleteButton: some View {
        DeleteButton(item: "Document", delete: delete)
    }

    private var sendButton: some View {
        Button {
            showSendMenu = true
        } label: {
            Image(systemName: "paperplane.fill")
        }
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            editButton
        }

        ToolbarItem(placement: .destructiveAction) {
            deleteButton
        }

        ToolbarItem(placement: .confirmationAction) {
            sendButton
        }
    }
}
