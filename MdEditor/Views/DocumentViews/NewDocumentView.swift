//
//  NewDocumentView.swift
//  MdEditor
//
//  Created by Zack Williams on 13-11-2026.
//

import SwiftData
import SwiftUI

struct NewDocumentView: View {
    @Binding var showing: Bool

    @State private var newDocument: MarkdownDocument = .init()
    @State private var showCancelConfirmation = false

    @Environment(DataContainer.self) private var dataContainer

    private var discardButton: some View {
        Button("Discard Document", role: .destructive) {
            showing = false
        }
    }

    private var cancelButton: some View {
        Button("Cancel", systemImage: "xmark") {
            if newDocument.content.isEmpty {
                showing = false
            } else {
                showCancelConfirmation = true
            }
        }
        .confirmationDialog(
            "Discard document",
            isPresented: $showCancelConfirmation
        ) {
            discardButton
        }
    }

    private var addButton: some View {
        Button("Add", systemImage: "checkmark") {
            newDocument.timestamp = .now

            dataContainer.context.insert(newDocument)

            do {
                try dataContainer.context.save()
                showing = false
            } catch {
                // Don't dismiss
            }
        }
        .disabled(newDocument.content.isEmpty)
    }
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            cancelButton
        }

        ToolbarItem(placement: .confirmationAction) {
            addButton
        }
    }

    var body: some View {
        NavigationStack {
            ContentEditView(
                content: $newDocument.content,
                location: $newDocument.location
            )
            .toolbar {
                toolbarContent
            }
            .navigationTitle("Add new document")

        }
        }
    }
}

#Preview {
    NewDocumentView(showing: .constant(true))
        .sampleDataContainer()
}
