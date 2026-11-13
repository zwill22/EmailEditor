//
//  DocumentDetailView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct DocumentDetailView: View {
    @State private var editMode = false
    @State private var showConfirmation = false
    @State private var showSendMenu = false

    var document: Document
    @Binding var showSidebar: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    private var contentStack: some View {
        VStack(alignment: .leading) {
            Text(
                document.timestamp
                    .formatted(date: .long, time: .shortened)
            )
            .font(.subheadline).padding(.bottom, 4)

            DocumentContentView(content: document.content)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }

    private var editButton: some View {
        Button {
            editMode = true
            showSidebar = false
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
                dataContainer.context.delete(document)
                try? dataContainer.context.save()
                dismiss()
            }
        } message: {
            Text("The message will be permenently deleted")
        }
    }

    private var sendButton: some View {
        Button {
            showSendMenu = true
        } label: {
            Image(systemName: "paperplane.fill")
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

        ToolbarItem(placement: .confirmationAction) {
            sendButton
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .navigationTitle(document.subject)
            .toolbar {
                toolbarContent
            }
            .sheet(isPresented: $showSendMenu) {
                EmailView(document: document)
            }

            .navigationDestination(
                isPresented: $editMode
            ) {
                EditDocumentView(document: document, editing: $editMode)
                    .onDisappear {
                        showSidebar = true
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DocumentDetailView(
            document: .sample,
            showSidebar: .constant(false)
        )
        .sampleDataContainer()
    }
}
