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
    @State private var showSaveConfirmation = false
    @State private var showCancelConfirmation = false

    @Environment(DataContainer.self) private var dataContainer

    var discardButton: some View {
        Button("Discard Changes", role: .destructive) {
            editing = false
        }
    }

    var cancelButton: some View {
        Button {
            if content == document.content {
                editing = false
            } else {
                showCancelConfirmation = true
            }
        } label: {
            Label("Cancel", systemImage: "xmark")
        }
        .confirmationDialog(
            "Discard changes",
            isPresented: $showCancelConfirmation
        ) {
            discardButton
        }
    }

    var saveAndExitButton: some View {
        Button("Save", role: .confirm) {
            document.content = content
            document.timestamp = .now

            dataContainer.context.insert(document)

            do {
                try dataContainer.context.save()

                editing = false
            } catch {
                //
            }
        }
    }

    var saveButton: some View {
        Button {
            if content == document.content {
                editing = false
            } else {
                showSaveConfirmation = true
            }
        } label: {
            Label("Save", systemImage: "checkmark")
        }
        .confirmationDialog(
            "Save changes",
            isPresented: $showSaveConfirmation
        ) {
            saveAndExitButton
        }
        .disabled(content == document.content)
    }

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .destructiveAction) {
            cancelButton
        }

        ToolbarItem(placement: .confirmationAction) {
            saveButton
        }
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
