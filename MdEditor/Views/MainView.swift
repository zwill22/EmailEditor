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
    
    @State private var showSidebar = true
    @State private var showNewDocumentView = false
    @State private var visibility: NavigationSplitViewVisibility = .all

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        if showSidebar {
            ToolbarItem {
                Button {
                    showNewDocumentView = true
                    showSidebar = false
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
            )
            .toolbar(removing: visibility == .detailOnly ? .sidebarToggle : nil)
            .toolbar {
                toolbarContent
            }
        } detail: {
            if showNewDocumentView {
                NewDocumentView(showing: $showNewDocumentView).onDisappear {
                    showSidebar = true
                }
            } else if let document = selection {
                DocumentDetailView(
                    document: document,
                    showSidebar: $showSidebar,
                )
            } else {
                ContentUnavailableView(
                    "Select document",
                    systemImage: "exclamationmark.circle.fill"
                )
            }
        }
        .onChange(of: showSidebar) { oldValue, newValue in
            if newValue == true {
                visibility = .all
            }
            
            if newValue == false {
                visibility = .detailOnly
            }
        }
    }
}

#Preview {
    MainView()
        .sampleDataContainer()
}
