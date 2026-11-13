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
    @State private var visibility = NavigationSplitViewVisibility.automatic
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            ListView(documents: documents, selection: $selection)
        } detail: {
            if let document = selection {
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
