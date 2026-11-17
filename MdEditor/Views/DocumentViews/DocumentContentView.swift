//
//  DocumentView.swift
//  MdEditor
//
//  Created by Zack Williams on 22-10-2026.
//

import MarkdownView
import SwiftUI

struct RelativeLocalImageRenderer: MarkdownImageRenderer {
    private func FallbackView(configuration: Configuration) -> some View {
        Rectangle().fill(.fill).frame(width: 400, height: 300)
            .overlay {
                ContentUnavailableView(
                    configuration.url.absoluteString.split(separator: "//")
                        .last!,
                    systemImage: "photo.artframe.circle",
                    description: Text(configuration.alternativeText ?? "")
                )
            }
    }

    func makeBody(configuration: Configuration) -> some View {
        FallbackView(configuration: configuration)
    }
}

struct DocumentContentView: View {
    @AppStorage("codeTheme") private var codeTheme: CodeTheme = .xcode
    @AppStorage("blockQuoteTheme") private var blockQuoteTheme:
        BlockQuoteTheme = .github

    private var regex = Regex(
        pattern:
            "!\\[(.*)\\]\\(((?:\\.{1,2}\\/)?(?:[\\w.-]+\\/)*[\\w.-]+)"
    )

    private var renderer = RelativeLocalImageRenderer()

    var content: String
    var path: String?

    var markdownView: some View {
        let pathString = URL(filePath: path ?? "").standardized.path()
        
        return MarkdownText(
            regex.replace(
                inputString: content,
                substitutionString: "![$1](relativePath://\(pathString)$2"
            )
        )
    }

    @ViewBuilder
    var markdownTextView: some View {
        AnyView(
            markdownView
                .markdownTableStyle(.github)
                .markdownBlockQuoteStyle(blockQuoteTheme.style)
                .markdownCodeBlockStyle(
                    .default(
                        lightTheme: codeTheme.lightTheme,
                        darkTheme: codeTheme.darkTheme
                    )
                )
                .markdownElementRenderer(
                    .image(renderer, urlScheme: "relativePath")
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
        content: MarkdownDocument.sample.content
    )
}

#Preview("Code Preview") {
    DocumentContentView(
        content: MarkdownDocument.codeSample.content
    )
}

#Preview("Quote Preview") {
    DocumentContentView(
        content: MarkdownDocument.sampleData[4].content
    )
}
