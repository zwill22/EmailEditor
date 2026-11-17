//
//  ContentEditView.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

struct ContentEditView: View {
    @Binding var content: String
    @Binding var location: URL?

    var body: some View {

        HStackLayout {
            Editor(content: $content)

            Divider()

            DocumentContentView(content: content, path: location?.path())
        }
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    ContentEditView(
        content: .constant(MarkdownDocument.codeSample.content),
        location: .constant(nil)
    )
}
