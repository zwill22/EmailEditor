//
//  EmailView.swift
//  MdEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftUI

struct EmailView: View {
    @Environment(\.dismiss) private var dismiss

    @State var document: Document

    @State var title = ""
    @State var sendToMe = true
    @State var newAddresses: [Address] = [.init(address: "")]

    private var templates = ["Plain"]
    @State private var selectedTemplate = "Plain"

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                dismiss()
            }
        }

        ToolbarItem(placement: .confirmationAction) {
            Button("Send", systemImage: "paperplane.fill") {
                // Send message
                dismiss()
            }
        }
    }

    var body: some View {
        Form {
            TextField("Subject", text: $title).font(.title)

            if !document.addresses.isEmpty {
                Divider()

                AddressList(addresses: $document.addresses)

                Divider()
            }

            AddressEditor(addresses: $newAddresses)
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.title2)

            Divider()

            Toggle("Send to me", isOn: $sendToMe)

            Picker("Template", selection: $selectedTemplate) {
                ForEach(templates, id: \.self) { template in
                    Text(template)
                }
            }
            .padding(.top)
        }
        .toolbar {
            toolbarContent
        }
        .padding()
    }

}

#Preview {
    EmailView(document: .sample)
}
