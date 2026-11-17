//
//  ListView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftUI

struct ListView: View {
    var documents: [MarkdownDocument]

    @Binding var selection: MarkdownDocument?
    private var pathItems: some View {
        List(documents, id: \.self, selection: $selection) { document in
            ListItem(document: document)
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

    var body: some View {
        NavigationStack {
            pathItems.frame(maxWidth: .infinity)
                .overlay {
                    overlayContent
                }
                .navigationTitle("Saved documents")
        }
    }
}

#Preview {
    ListView(documents: MarkdownDocument.sampleData, selection: .constant(nil))
}

#Preview("No documents") {
    ListView(documents: [], selection: .constant(nil))
}
