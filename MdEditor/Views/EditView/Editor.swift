//
//  Editor.swift
//  MdEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftUI

struct Editor: View {
    @Binding var document: Document

    var body: some View {
        TextEditor(text: $document.content)
            .multilineTextAlignment(.leading)
            .scrollContentBackground(.hidden)
            .foregroundColor(.primary)
            .background(Color.clear)
            .font(.title3)
            .padding()
    }
}

#Preview {
    Editor(document: .constant(.sample))
}
