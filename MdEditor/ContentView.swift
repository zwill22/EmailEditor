//
//  ContentView.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            MessageView()
        } detail: {
            ContentUnavailableView(
                "Select message",
                systemImage: "exclamationmark.circle.fill"
            )
        }

    }
}

#Preview {
    ContentView()
        .sampleDataContainer()
}
