//
//  MessageViewer.swift
//  EmailEditor
//
//  Created by Zack Williams on 22-10-2026.
//

import MarkdownView
import SwiftUI

struct MessageContentView: View {
    var message: Message

    private var contentStack: some View {
        VStack(alignment: .leading) {
            Grid(alignment: .leading, verticalSpacing: 8) {
                GridRow {
                    Text("Title:").foregroundStyle(.placeholder).italic()

                    if message.title.isEmpty {
                        Text("Title").font(.title).foregroundStyle(.placeholder)
                    } else {
                        Text(message.title).font(.title)
                    }
                }

                GridRow {
                    Text("To:").foregroundStyle(.placeholder)
                        .italic()

                    ForEach(message.addresses) { address in
                        Text(address.address).font(.title2)
                    }
                }
            }
           
            Divider().padding(.vertical)

            if message.message.isEmpty {
                ContentUnavailableView(
                    "Empty message",
                    systemImage: "long.text.page.and.pencil",
                    description: Text("Type message to render here")
                ).padding()
            } else {
                MarkdownText(message.message)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }

        }
    }

    var body: some View {
        ScrollView {
            contentStack
        }
        .scrollDismissesKeyboard(.interactively)
    }
}
#Preview {
    MessageContentView(
        message: Message.sample
    )
}
