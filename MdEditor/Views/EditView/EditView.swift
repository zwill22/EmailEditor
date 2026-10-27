//
//  EditView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct EditView: View {
    @State var document: Document = .init()

    @State private var isShowingCancelConfirmation = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                if document.content.isEmpty {
                    dismiss()
                } else {
                    isShowingCancelConfirmation = true
                }
            }
            .confirmationDialog(
                "Discard document",
                isPresented: $isShowingCancelConfirmation
            ) {
                Button("Discard document", role: .destructive) {
                    dismiss()
                }
            }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Add", systemImage: "checkmark") {
                let newMessage = document
                document.timestamp = .now

                dataContainer.context.insert(newMessage)

                do {
                    try dataContainer.context.save()
                    dismiss()
                } catch {
                    // Don't dismiss
                }
            }
            .disabled(document.content.isEmpty)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                HStackLayout {
                    Editor(document: $document)

                    Divider()

                    DocumentView(document: document)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Editor")
            .toolbar {
                toolbarContent
            }
        }
    }
}

#Preview {
    EditView().sampleDataContainer()
}
