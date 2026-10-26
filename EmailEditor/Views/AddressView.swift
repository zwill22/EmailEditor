//
//  AddressView.swift
//  EmailEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftUI

struct AddressView: View {
    @Binding var addresses: [Message.Address]
    
    private let rowHeight: CGFloat = 32
    private let padY: CGFloat = 36

    var body: some View {
        List {
            ForEach(addresses) { address in
                Text(address.address).lineLimit(1)
                    .frame(height: rowHeight)
            }
        }
        .frame(height: CGFloat(addresses.count) * rowHeight + padY)
    }
}

#Preview {
    AddressEditView(addresses: .constant(Message.sample.addresses))
}
