//
//  AddressEditView.swift
//  EmailEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftUI

struct AddressEditView: View {
    @Binding var addresses: [Message.Address]
    @State var newAddress = ""

    @State private var selectedItems: Set<UUID> = []
    
    private let rowHeight: CGFloat = 32
    private let padY: CGFloat = 36

    var body: some View {
        List(selection: $selectedItems) {
            ForEach(addresses) { address in
                Text(address.address).lineLimit(1)
                    .frame(height: rowHeight)
            }
            .onMove { indexSet, offset in
                addresses.move(fromOffsets: indexSet, toOffset: offset)
            }
            .onDelete { index in
                addresses.remove(atOffsets: index)
            }
        }
        .frame(height: CGFloat(addresses.count) * rowHeight + padY)
        
        HStack {
            TextField("New Address", text: $newAddress)
            Button(
                action: {
                    withAnimation {
                        let address = Message.Address(
                            address: newAddress
                        )
                        addresses.append(address)
                        newAddress = ""
                    }
                },
                label: {
                    Image(systemName: "plus.circle.fill")
                        .accessibilityLabel("Add address")
                }
            ).disabled(newAddress.isEmpty)
        }
    }
}

#Preview {
    AddressEditView(addresses: .constant(Message.sample.addresses))
}
