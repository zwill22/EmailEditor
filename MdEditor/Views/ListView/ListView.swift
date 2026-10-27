//
//  ListView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct ListView: View {
    var documents: [Document]
    
    @State private var showCreateDocument = false

    private var pathItems: some View {
        List {
            ForEach(documents) { document in
                NavigationLink {
                    DocumentView(document: document)
                } label: {
                    ListItem(document: document)
                }
            }
        }
        .frame(minWidth: 300)
    }

    @ContentBuilder
    private var overlayContent: some View {
        if documents.isEmpty {
            ContentUnavailableView {
                Label(
                    "No documents",
                    systemImage: "exclamationmark.circle.fill"
                )
            } description: {
                Text("Add a document to see list of saved documents")
            }
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            NavigationLink {
                EditView()
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    var body: some View {
        NavigationStack {
            pathItems.frame(maxWidth: .infinity)
                .overlay {
                    overlayContent
                }
                .toolbar {
                    toolbarContent
                }
                .navigationTitle("Saved documents")
        }
    }
}

#Preview {
    ListView(documents: Document.sampleData)
}

#Preview("No documents") {
    ListView(documents: [])
}
