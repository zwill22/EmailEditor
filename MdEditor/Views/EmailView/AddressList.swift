//
//  AddressList.swift
//  MdEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftUI

struct AddressList: View {
    @Binding var addresses: [Address]

    private func copy(index: Int) {
        NSPasteboard.general.declareTypes([.string], owner: nil)
        NSPasteboard.general.setString(
            addresses[index].address,
            forType: .string
        )
    }
    
    private func copyButton(index: Int) -> some View {
        Button {
            copy(index: index)
        } label: {
            Image(systemName: "document.on.document")
        }
    }

    var body: some View {
        ForEach(addresses.indices, id: \.self) { index in
            HStack {
                TextField(
                    index == 0 ? "Sent to" : "",
                    text: $addresses[index].address
                )
                .disabled(true)
                
                copyButton(index: index)
            }
        }
    }
}

#Preview {
    AddressList(addresses: .constant(Address.sampleData))
}
