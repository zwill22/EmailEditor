//
//  ExportButton.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import SwiftData
import SwiftUI

struct ExportButton: View {
    @Binding var document: MarkdownDocument
    @Binding var errorHandler: ErrorHandler

    @State private var showFileExporter = false

    @Environment(DataContainer.self) private var dataContainer

    private var resaveButton: some View {
        Button("Save", systemImage: "externaldrive") {
            do {
                try document.save()
            } catch {
                errorHandler.handle(error)
            }
        }
    }

    private var saveAsButton: some View {
        Button("Save to folder", systemImage: "plus.rectangle.on.folder") {
            showFileExporter = true
        }
        .fileExporter(
            isPresented: $showFileExporter,
            document: document
        ) { result in
            switch result {
            case .success(let url):
                document.location = url
            case .failure(let error):
                errorHandler.handle(error)
            }
        }
    }

    var body: some View {
        if document.location != nil {
            resaveButton
        } else {
            saveAsButton
        }
    }
}
