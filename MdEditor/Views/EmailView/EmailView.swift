//
//  EmailView.swift
//  MdEditor
//
//  Created by Zack Williams on 26-10-2026.
//

import SwiftData
import SwiftUI

struct EmailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openWindow) private var openWindow

    @Query private var credentials: [EmailCredentials]

    @State private var selectedAccount: PersistentIdentifier? = nil

    @State var document: MarkdownDocument

    @State var title = ""
    @State var preview = ""
    @State var includePreview = false
    @State var sendToMe = true
    @State var newAddresses: [Address] = [.init(address: "")]

    @State var provider = TemplateProvider()

    @State private var selectedTemplate: String? = nil
    @State private var error: EditorError?
    @State private var hasError = false

    @State private var showNewAccountMenu = false

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

                do {
                    let _ = try buildEmail()

                    dismiss()
                } catch {
                    self.error =
                        error as? EditorError
                        ?? .unexpectedError(error: error)

                    self.hasError = true
                }
            }
            .disabled(
                title.isEmpty && newAddresses.allSatisfy({ $0.address.isEmpty })
            )
        }
    }

    func openPreview() {
        do {
            let htmlString = try buildEmail()

            openWindow(id: "htmlPreview", value: htmlString)

        } catch {
            self.error =
                error as? EditorError
                ?? .unexpectedError(error: error)

            self.hasError = true
        }
    }

    var previewButton: some View {
        Button {
            openPreview()
        } label: {
            Text("Preview")
        }
    }

    func buildEmail() throws -> String {
        guard let selection = selectedTemplate else {
            fatalError("Invalid template")
        }

        guard let template = provider.get(name: selection) else {
            fatalError("Unable to get template from provider")
        }

        return try template.fill(values: [
            "content": document.asHtml(),
            "title": title,
            "previewText": document.getPreview(
                include: includePreview,
                text: preview
            ),
        ])

    }

    func fetchTemplates() {
        do {
            try provider.fetchTemplates()
        } catch {
            self.error =
                error as? EditorError ?? .unexpectedError(error: error)

            self.hasError = true
        }
    }

    var addressSelector: some View {
        Section {
            if !document.addresses.isEmpty {
                Divider()

                AddressList(addresses: $document.addresses)

                Divider()
            }

            AddressEditor(addresses: $newAddresses)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }

    var accountPicker: some View {
        Picker("Email account", selection: $selectedAccount) {
            ForEach(credentials) { account in
                Text("\(account.name) - \(account.emailAddress.address)").tag(
                    account.persistentModelID
                )
            }
        }.pickerStyle(.automatic)
    }

    private var addAccountButton: some View {
        Button {
            self.showNewAccountMenu = true
        } label: {
            Image(systemName: "plus.circle.fill")
        }
        .sheet(isPresented: $showNewAccountMenu) {
            self.showNewAccountMenu = false
        } content: {
            NewAccountView().navigationTitle("Add Email Account").padding()
        }

    }

    var accountMenu: some View {
        HStack {
            accountPicker
            addAccountButton
        }
    }

    var templatePicker: some View {
        Picker(
            "Template",
            selection: $selectedTemplate
        ) {
            ForEach(provider.templates) { template in
                Text(template.name).tag(template.name)
            }
        }
    }

    var templateMenu: some View {
        HStack {
            templatePicker
            previewButton
        }
    }

    var body: some View {
        Form {
            accountMenu

            TextField("Subject", text: $title)

            HStack {

                TextField("Preview", text: $preview)
                    .disabled(!includePreview)

                Toggle("Include Preview", isOn: $includePreview).labelsHidden()
                    .toggleStyle(.switch)
            }

            addressSelector

            Divider()

            Toggle("Send to me", isOn: $sendToMe)

            templateMenu.padding(.top)
        }
        .toolbar {
            toolbarContent
        }
        .padding()
        .alert(isPresented: $hasError, error: error) {}
        .task {
            fetchTemplates()
        }

    }

}

#Preview {
    EmailView(document: .sample)
        .sampleDataContainer()
}
