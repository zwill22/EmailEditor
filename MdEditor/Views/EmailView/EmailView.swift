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

    @State var provider = TemplateProvider()

    @State private var selection: String = "Plain"
    @State private var error: TemplateError?
    @State private var hasError = false

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

    func fetchTemplates() {
        do {
            try provider.fetchTemplates()
        } catch {
            self.error =
                error as? TemplateError ?? .unexpectedError(error: error)

            self.hasError = true
        }
    }

    var templatePicker: some View {
        Picker(
            "Template",
            selection: $selection
        ) {
            ForEach(provider.templates) { template in
                Text(template.name).tag(template.name)
            }
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Subject", text: $title).font(.title2)

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

                templatePicker.padding(.top)
            }
            .toolbar {
                toolbarContent
            }
            .padding()
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            fetchTemplates()
        }

    }

}

#Preview {
    EmailView(document: .sample)
}
