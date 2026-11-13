//
//  MainView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct MainView: View {
    @Query(sort: \Document.timestamp, order: .reverse)

    private var documents: [Document]

    @State private var selection: Document? = nil

    @State private var showNewDocumentView = false
    @State private var visibility: NavigationSplitViewVisibility = .all

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        if !showNewDocumentView {
            ToolbarItem {
                Button {
                    showNewDocumentView = true
                    visibility = .detailOnly
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            ListView(
                documents: documents,
                selection: $selection,
            ).toolbar {
                toolbarContent
            }
        } detail: {
            if showNewDocumentView {
                NewDocumentView(showing: $showNewDocumentView).onDisappear {
                    visibility = .all
                }
            } else if let document = selection {
                DocumentDetailView(document: document, visibility: $visibility)
            } else {
                ContentUnavailableView(
                    "Select document",
                    systemImage: "exclamationmark.circle.fill"
                )
            }
        }
    }
}

#Preview {
    MainView()
        .sampleDataContainer()
}
