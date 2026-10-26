//
//  SendView.swift
//  EmailEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftUI

struct SendView: View {
    @State var message: Message

    @State var title = ""
    @State var addresses: [Message.Address] = []

    var body: some View {
        NavigationStack {
            TextField(text: $title) {
                Text("Title")
            }
            .font(.title.bold())

            if !message.addresses.isEmpty {
                HStack {
                    Text("Previous Recipients").frame(maxWidth: 64)

                    AddressView(addresses: $message.addresses)
                        .foregroundStyle(Color.secondary)
                }
                
                Divider()
            }
            
            HStack(alignment: .top) {
                Text("To").frame(minWidth: 64, maxWidth: 64)
                    .border(.pink)
                AddressEditView(addresses: $addresses)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.title2)
            }
            .padding(.top)
        }
        .padding()
    }

}

#Preview {
    SendView(message: .sample)
}
