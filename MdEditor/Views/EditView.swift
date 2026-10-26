//
//  EditView.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct EditView: View {
    @State var message: Message = .emptyMessage

    @State private var isShowingCancelConfirmation = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                if message.allEmpty {
                    dismiss()
                } else {
                    isShowingCancelConfirmation = true
                }
            }
            .confirmationDialog(
                "Discard message",
                isPresented: $isShowingCancelConfirmation
            ) {
                Button("Discard message", role: .destructive) {
                    dismiss()
                }
            }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Add", systemImage: "checkmark") {
                let newMessage = message
                message.timestamp = .now

                dataContainer.context.insert(newMessage)

                do {
                    try dataContainer.context.save()
                    dismiss()
                } catch {
                    // Don't dismiss
                }
            }
            .disabled(message.emptyField)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                HStackLayout {
                    MessageEditView(message: $message)

                    Divider()

                    MessageContentView(message: message)
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
