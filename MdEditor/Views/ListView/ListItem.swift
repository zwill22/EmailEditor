//
//  ListItem.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import MarkdownView
import SwiftUI

struct ListItem: View {
    var document: Document

    var body: some View {
        HStack {
            Icon(height: 60)

            VStack(alignment: .leading) {

                Text(document.title)
                    .lineLimit(1)
                    .font(.title)
                    .padding(.bottom, 2)

                Text(document.start)
                    .font(.caption)
                    .italic()
                    .lineLimit(1)
            }

            Spacer()

            Timestamp(timestamp: document.timestamp)
        }
    }
}

#Preview {
    ListItem(document: .sample)
}
