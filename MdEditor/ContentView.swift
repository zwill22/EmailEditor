//
//  ContentView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Document.timestamp, order: .reverse)
    
    private var documents: [Document]
    
    var body: some View {
        NavigationSplitView {
            ListView(documents: documents)
        } detail: {
            ContentUnavailableView(
                "Select document",
                systemImage: "exclamationmark.circle.fill"
            )
        }

    }
}

#Preview {
    ContentView()
        .sampleDataContainer()
}
