//
//  MessageEditView.swift
//  EmailEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftUI

struct MessageEditView: View {
    @Binding var message: Message

    var body: some View {
        TextEditor(text: $message.message)
            .multilineTextAlignment(.leading)
            .scrollContentBackground(.hidden)
            .foregroundColor(.primary)
            .background(Color.clear)
            .font(.title3)
            .padding()
    }
}

#Preview {
    EditView().sampleDataContainer()
}
