//
//  NewDocumentView.swift
//  MdEditor
//
//  Created by Zack Williams on 13-11-2026.
//

import SwiftData
import SwiftUI

struct NewDocumentView: View {
    @Binding var showing: Bool

    @State private var newDocument: MarkdownDocument = .init()
    @State private var errorHandler: ErrorHandler = .init()

    var toolbarContent: some ToolbarContent {
        NewDocumentToolbar(
            showing: $showing,
            newDocument: $newDocument,
            errorHandler: $errorHandler
        )
    }

    var body: some View {
        NavigationStack {
            ContentEditView(
                content: $newDocument.content,
                location: $newDocument.location
            )
            .toolbar {
                toolbarContent
            }
            .navigationTitle("Add new document")

        }
        .alert(isPresented: $errorHandler.hasError, error: errorHandler.error) {
        }
    }
}

#Preview {
    NewDocumentView(showing: .constant(true))
        .sampleDataContainer()
}
