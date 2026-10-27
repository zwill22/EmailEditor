//
//  AddressEditor.swift
//  MdEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftUI

struct AddressEditor: View {
    @Binding var addresses: [Address]

    @State private var selectedItems: Set<UUID> = []

    private func removeAddressButton(index: Int) -> some View {
        Button {
            addresses.remove(at: index)
        } label: {
            Image(systemName: "minus.circle.fill")
        }
    }

    private var addAddressButton: some View {
        Button {
            addresses.append(Address(address: ""))
        } label: {
            Image(systemName: "plus.circle.fill")
        }
    }

    var body: some View {
        if addresses.isEmpty {
            addAddressButton.frame(minWidth: 0, maxWidth: .infinity)
        } else {
            ForEach(addresses.indices, id: \.self) { index in
                HStack {
                    TextField(
                        index == 0 ? "To" : "",
                        text: $addresses[index].address
                    )

                    if index == addresses.count - 1 {
                        addAddressButton
                    } else {
                        removeAddressButton(index: index)
                    }
                }
            }
        }
    }
}

#Preview {
    AddressEditor(addresses: .constant(Address.sampleData))
}
