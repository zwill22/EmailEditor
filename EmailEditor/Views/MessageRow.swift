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
        HStack {
            MessageIcon(height: 60)

            VStack(alignment: .leading) {

                Text(message.title)
                    .lineLimit(1)
                    .font(.title)
                    .padding(.bottom, 2)

                Text(message.message).font(.caption).italic()
                    .lineLimit(1)
            }

            Spacer()

            MessageTimestamp(timestamp: message.timestamp)
        }
    }
}

#Preview {
    MessageRow(message: .sample)
}
