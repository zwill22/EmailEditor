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
    @Query(sort: \Message.timestamp)
    private var messages: [Message]

    var body: some View {
        NavigationStack {
            pathItems.frame(maxWidth: .infinity)
                .overlay {
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
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showCreateMessage = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showCreateMessage) {
                            EditView()
                        }
                    }
                }
                .navigationTitle("Saved messages")
        }
    }

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
}

#Preview {
    MessageView()
        .sampleDataContainer()
}

#Preview("No messages") {
    MessageView()
        .modelContainer(for: [Message.self])
}
