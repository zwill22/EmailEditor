//
//  MainView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: \Document.timestamp, order: .reverse)

    private var documents: [Document]

    @State private var selection: Document? = nil

    var body: some View {
        NavigationSplitView {
            ListView(documents: documents, selection: $selection)
        } detail: {
            if let document = selection {
                DetailView(document: document)
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
    ContentView()
        .sampleDataContainer()
}
