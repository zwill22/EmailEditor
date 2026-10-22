//
//  MessageRow.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftUI

struct MessageRow: View {
    var message: Message

    var body: some View {
        HStack(alignment: .center) {
            MessageIcon(height: 60)

            VStack(alignment: .leading) {

                Text(message.title)
                    .lineLimit(1, reservesSpace: true)
                    .font(.title)
                    .padding(.bottom, 2)

                Text(message.message).font(.caption).italic()

            }
        }
    }
}

#Preview {
    MessageRow(message: .sample)
}
