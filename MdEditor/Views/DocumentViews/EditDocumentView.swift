//
//  EditDocumentView.swift
//  MdEditor
//
//  Created by Zack Williams on 13-11-2026.
//

import SwiftData
import SwiftUI

struct EditDocumentView: View {
    var document: MarkdownDocument
    @Binding var editing: Bool

    @State private var content: String = ""
    @State private var location: URL? = nil

    @State private var errorHandler: ErrorHandler = .init()

    var toolbarContent: some ToolbarContent {
        EditDocumentToolbar(
            document: document,
            editing: $editing,
            content: $content,
            location: $location,
            errorHandler: $errorHandler
        )
    }

    var body: some View {
        NavigationStack {
            ContentEditView(content: $content, location: $location)
                .onAppear {
                    content = document.content
                    location = document.location
                }
                .navigationBarBackButtonHidden()
                .navigationTitle("Editing Document")
                .toolbar {
                    toolbarContent
                }
        }
    }
}

#Preview {
    EditDocumentView(document: .codeSample, editing: .constant(true))
}
