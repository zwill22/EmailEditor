//
//  EditView.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct EditView: View {
    @State var title = ""
    @State var address = ""
    @State var message = ""

    @State private var isShowingCancelConfirmation = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    private var editor: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
            .font(.title.bold())

            TextField(text: $address) {
                Text("Recipient")
            }
            .font(.title2)
            .padding(.top, 12)

            Divider().padding(.vertical, 12)

            TextEditor(text: $message)
                .font(.title3)
                .frame(minHeight: 192)

        }
        .padding()
    }

    private var content: some View {
        HStack(alignment: .top, spacing: 0) {
            editor
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Divider()
            
            RenderedMessageView(
                title: $title,
                address: $address,
                message: $message
            ).padding(.top, 16)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                if title.isEmpty, message.isEmpty, address.isEmpty {
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
                let newMessage = Message(
                    title: title,
                    message: message,
                    addresses: [address],
                    timestamp: .now
                )

                dataContainer.context.insert(newMessage)

                do {
                    try dataContainer.context.save()
                    dismiss()
                } catch {
                    // Don't dismiss
                }
            }
            .disabled(title.isEmpty)
            .disabled(address.isEmpty)
            .disabled(message.isEmpty)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                content
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
