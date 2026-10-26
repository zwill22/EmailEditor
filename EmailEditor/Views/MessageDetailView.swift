//
//  MessageDetailView.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct MessageDetailView: View {
    var message: Message

    @State private var showConfirmation = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    private var contentStack: some View {
        VStack(alignment: .leading) {
            Text(message.timestamp, style: .date).font(.subheadline).padding(.bottom, 4)
            MessageContentView(message: message)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }

    private var editButton: some View {
        NavigationLink {
            EditView(message: message)
        } label: {
            Image(systemName: "long.text.page.and.pencil")
        }
    }

    private var deleteButton: some View {
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

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            editButton
        }

        ToolbarItem(placement: .destructiveAction) {
            deleteButton
        }
    }

    var body: some View {
        ScrollView {
            contentStack
        }
        .navigationTitle(message.title)
        .toolbar {
            toolbarContent
        }
    }
}

#Preview {
    NavigationStack {
        MessageDetailView(message: .sample)
            .sampleDataContainer()
    }
}
