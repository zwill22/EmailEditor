//
//  DocumentView.swift
//  MdEditor
//
//  Created by Zack Williams on 22-10-2026.
//

import MarkdownView
import SwiftUI

struct DocumentView: View {
    var document: Document

    var body: some View {
        VStack {
            if document.content.isEmpty {
                Spacer()

                ContentUnavailableView(
                    "Empty document",
                    systemImage: "long.text.page.and.pencil",
                    description: Text("Type document to render here")
                )

                Spacer()
            } else {
                MarkdownText(document.content)
                    .markdownTableStyle(.github)
                    .markdownBlockQuoteStyle(.github)
                    .markdownCodeBlockStyle(
                        .default(
                            lightTheme: "xcode",
                            darkTheme: "xcode-dark"
                        )
                    )

                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    DocumentView(
        document: .sample
    )
}

#Preview("Code Preview") {
    DocumentView(
        document: .codeSample
    )
}

#Preview("Quote Preview") {
    DocumentView(
        document: .sampleData[4]
    )
}
