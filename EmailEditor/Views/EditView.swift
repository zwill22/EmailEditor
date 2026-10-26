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

    @State private var newAddress = ""
    @State private var isShowingCancelConfirmation = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    private var editor: some View {
        VStack(alignment: .leading) {
            Form {
                TextField(text: $message.title) {
                    Text("Title")
                }
                .font(.title.bold())

                Section(header: Text("Recipients")) {
                    ForEach(message.addresses) { address in
                        Text(address.address)
                    }
                    .onDelete { indices in
                        message.addresses.remove(atOffsets: indices)
                    }

                    HStack {
                        TextField("New Address", text: $newAddress)
                        Button(
                            action: {
                                withAnimation {
                                    let address = Message.Address(
                                        address: newAddress
                                    )
                                    message.addresses.append(address)
                                    newAddress = ""
                                }
                            },
                            label: {
                                Image(systemName: "plus.circle.fill")
                                    .accessibilityLabel("Add address")
                            }
                        ).disabled(newAddress.isEmpty)
                    }
                }
                .font(.title2)
                .padding(.top, 12)
            }

            Divider().padding(.vertical, 12)

            TextEditor(text: $message.message)
                .font(.title3)
                .frame(minHeight: 256)

        }
        .padding()
    }

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
                editor
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
