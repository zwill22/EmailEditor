//
//  DocumentView.swift
//  MdEditor
//
//  Created by Zack Williams on 22-10-2026.
//

import MarkdownView
import SwiftUI

struct DocumentContentView: View {
    @AppStorage("codeTheme") private var codeTheme: CodeTheme = .xcode
    @AppStorage("blockQuoteTheme") private var blockQuoteTheme:
        BlockQuoteTheme = .github

    var content: String

    @ViewBuilder
    var markdownTextView: some View {
        AnyView(
            MarkdownText(content)
                .markdownTableStyle(.github)
                .markdownBlockQuoteStyle(blockQuoteTheme.style)
                .markdownCodeBlockStyle(
                    .default(
                        lightTheme: codeTheme.lightTheme,
                        darkTheme: codeTheme.darkTheme
                    )
                )
        )
    }

    var body: some View {
        VStack {
            if content.isEmpty {
                Spacer()

                ContentUnavailableView(
                    "Empty document",
                    systemImage: "long.text.page.and.pencil",
                    description: Text("Type document to render here")
                )

                Spacer()
            } else {
                ScrollView {
                    markdownTextView
                }

                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    DocumentContentView(
        content: Document.sample.content
    )
}

#Preview("Code Preview") {
    DocumentContentView(
        content: Document.codeSample.content
    )
}

#Preview("Quote Preview") {
    DocumentContentView(
        content: Document.sampleData[4].content
    )
}
