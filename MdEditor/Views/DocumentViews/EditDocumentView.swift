//
//  EditDocumentView.swift
//  MdEditor
//
//  Created by Zack Williams on 13-11-2026.
//

import SwiftData
import SwiftUI

struct EditDocumentView: View {
    var document: Document

    @Binding var editing: Bool

    @State private var content: String = ""

    @Environment(DataContainer.self) private var dataContainer

    private func update() throws {
        document.content = content
        document.timestamp = .now

        dataContainer.context.insert(document)

        try dataContainer.context.save()

    }

    private func unchanged() -> Bool {
        return content == document.content
    }

    private func dismiss() {
        editing = false
    }

    var toolbarContent: some ToolbarContent {
        EditingToolbar(dismiss: dismiss, unchanged: unchanged, update: update)
    }

    var body: some View {
        NavigationStack {
            ContentEditView(content: $content)
                .onAppear {
                    content = document.content
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
