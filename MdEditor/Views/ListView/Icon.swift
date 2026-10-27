//
//  Icon.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftUI

struct Icon: View {
    @Binding var document: Document

    var height: CGFloat = 60

    var foreground: Color {
        .primary
    }

    var background: Color {
        .secondary
    }

    var image: some View {
        if document.addresses.isEmpty {
            Image(systemName: "text.document")
        } else if document.addresses.count == 1 {
            Image(systemName: "envelope.open")
        } else {
            Image(systemName: "envelope.stack.fill")
        }
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                background
            )
            .frame(width: 60, height: height)
            .overlay {
                image
                    .font(.largeTitle)
                    .foregroundStyle(
                        foreground
                    )
            }
    }
}

#Preview {
    ForEach(Document.sampleData) { sample in
        Icon(document: .constant(sample))
    }
}
