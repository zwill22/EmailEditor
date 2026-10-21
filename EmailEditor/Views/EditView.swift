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
                contentStack
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
                    .confirmationDialog("Discard message", isPresented: $isShowingCancelConfirmation) {
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

    var contentStack: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
            .font(.title.bold())
            .padding(.top, 48)

            TextField(text: $address) {
                Text("Recipient")
            }
            .font(.title2)
            .padding(.vertical, 12)

            Divider()

            TextField("Message", text: $message, axis: .vertical)
                .multilineTextAlignment(.leading)
                .lineLimit(10...Int.max)
        }
        .padding()
    }
}

#Preview {
    EditView()
        .sampleDataContainer()
}
