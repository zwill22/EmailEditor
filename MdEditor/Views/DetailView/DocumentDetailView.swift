//
//  DocumentDetailView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct DocumentDetailView: View {
    var document: Document

    @State private var editMode = false
    @State private var showConfirmation = false
    @State private var showSendMenu = false

    @Binding var visibility: NavigationSplitViewVisibility

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    private var contentStack: some View {
        VStack(alignment: .leading) {
            Text(
                document.timestamp
                    .formatted(date: .long, time: .shortened)
            )
            .font(.subheadline).padding(.bottom, 4)

            DocumentView(document: document)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }

    private var editButton: some View {
        Button {
            editMode = true
            visibility = .detailOnly
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
                EditView(document: document)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DocumentDetailView(document: .sample, visibility: .constant(.automatic))
            .sampleDataContainer()
    }
}
