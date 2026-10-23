//
//  MessageViewer.swift
//  EmailEditor
//
//  Created by Zack Williams on 22-10-2026.
//

import MarkdownView
import SwiftUI

struct RenderedMessageView: View {
    @Binding var title: String
    @Binding var address: String
    @Binding var message: String

    private var contentStack: some View {
        VStack(alignment: .leading) {
            if title.isEmpty {
                Text("Title").font(.title).foregroundStyle(.secondary)
            } else {
                Text(title).font(.title)
            }

            if address.isEmpty {
                Text("Recipient").font(.title2).italic().padding(.vertical, 12)
                    .foregroundStyle(.secondary)
            } else {
                Text(address).font(.title2).padding(.vertical, 12).italic()
                    .foregroundStyle(.secondary)
            }

            if message.isEmpty {
                ContentUnavailableView(
                    "Empty message",
                    systemImage: "long.text.page.and.pencil",
                    description: Text("Type message to render here")
                ).padding()
            } else {
                MarkdownText(message)
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
    @Previewable @State var exampleTitle = "A message"
    @Previewable @State var exampleAddress: String = "spock@1701a.fed"
    @Previewable @State var exampleMessage: String =
        "# Big title\n\n Complicated message"

    RenderedMessageView(
        title: $exampleTitle,
        address: $exampleAddress,
        message: $exampleMessage
    )
}
