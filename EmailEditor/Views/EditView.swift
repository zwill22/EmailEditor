//
//  EditView.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct EditView: View {
    @State private var title = ""
    @State private var address = ""
    @State private var message = ""

    @State private var isShowingCancelConfirmation = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(alignment: .top, spacing: 0) {
                    editor
                        .frame(minWidth: 0, maxWidth: .infinity)
                    RenderedMessageView(
                        title: $title,
                        address: $address,
                        message: $message
                    ).padding(.top, 16)

                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Editor")
            .toolbar {
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
        }
    }

    var editor: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
            .font(.title.bold())

            TextField(text: $address) {
                Text("Recipient")
            }
            .font(.title2)
            .padding(.vertical, 12)

            Divider()

            TextEditor(text: $message)
                .font(.title3)
                .frame(minHeight: 192)

        }
        .padding()
    }
}

#Preview {
    EditView().sampleDataContainer()
}
