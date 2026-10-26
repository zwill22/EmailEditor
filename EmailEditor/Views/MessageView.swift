//
//  MessageView.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct MessageView: View {
    @State private var showCreateMessage = false
    
    @Query(sort: \Message.timestamp, order: .reverse)
    
    private var messages: [Message]

    private var pathItems: some View {
        List {
            ForEach(messages) { message in
                NavigationLink {
                    MessageDetailView(message: message)
                } label: {
                    MessageRow(message: message)
                }
            }
        }
        .frame(minWidth: 300)
    }

    @ContentBuilder
    private var overlayContent: some View {
        if messages.isEmpty {
            ContentUnavailableView {
                Label(
                    "No messages",
                    systemImage: "exclamationmark.circle.fill"
                )
            } description: {
                Text("Add a message to see list of saved messages")
            }
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            NavigationLink {
                EditView()
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    var body: some View {
        NavigationStack {
            pathItems.frame(maxWidth: .infinity)
                .overlay {
                    overlayContent
                }
                .toolbar {
                    toolbarContent
                }
                .navigationTitle("Saved messages")
        }
    }
}

#Preview {
    MessageView()
        .sampleDataContainer()
}

#Preview("No messages") {
    MessageView()
        .modelContainer(for: [Message.self])
}
