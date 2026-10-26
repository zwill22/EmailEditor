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

    var body: some View {
        VStack {
            if message.message.isEmpty {
                Spacer()

                ContentUnavailableView(
                    "Empty message",
                    systemImage: "long.text.page.and.pencil",
                    description: Text("Type message to render here")
                )

                Spacer()
            } else {
                MarkdownText(message.message)

                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    MessageContentView(
        message: Message.sample
    )
}
