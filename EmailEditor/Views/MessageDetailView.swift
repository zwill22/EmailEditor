//
//  MessageDetailView.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct MessageDetailView: View {
    @Bindable var message: Message

    @State private var showConfirmation = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    var body: some View {
        ScrollView {
            contentStack
        }
        .navigationTitle(message.title)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button {
                    showConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
                .confirmationDialog(
                    "Delete message",
                    isPresented: $showConfirmation
                ) {
                    Button("Delete message", role: .destructive) {
                        dataContainer.context.delete(message)
                        try? dataContainer.context.save()
                        dismiss()
                    }
                } message: {
                    Text("The message will be permenently deleted")
                }
            }
        }
    }

    private var contentStack: some View {
        VStack(alignment: .leading) {
            Text(message.timestamp, style: .date).font(.subheadline)
            RenderedMessageView(
                title: $message.title,
                address: $message.addresses[0],
                message: $message.message
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    NavigationStack {
        MessageDetailView(message: .sample)
            .sampleDataContainer()
    }
}
