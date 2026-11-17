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
    @State private var showSendMenu = false

    var document: MarkdownDocument
    @Binding var showSidebar: Bool

    private var contentStack: some View {
        VStack(alignment: .leading) {
            Text(
                document.timestamp
                    .formatted(date: .long, time: .shortened)
            )
            .font(.subheadline).padding(.bottom, 4)

            DocumentContentView(
                content: document.content,
                path: document.location?.path()
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }

    private var toolbarContent: some ToolbarContent {
        DocumentDetailToolbar(
            document: document,
            editMode: $editMode,
            showSidebar: $showSidebar,
            showSendMenu: $showSendMenu
        )
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
