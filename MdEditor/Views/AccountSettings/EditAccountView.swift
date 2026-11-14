//
//  EditAccountView.swift
//  MdEditor
//
//  Created by Zack Williams on 14-11-2026.
//

import SwiftData
import SwiftUI

struct EditAccountView: View {
    var account: EmailAccount

    @State private var valid = false
    @State private var editedAccount: EmailAccount = .emptyAccount

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    private func validate() {
        Task {
            self.valid = await editedAccount.isValid()
        }
    }

    private func dismissFn() {
        dismiss()
    }

    private func unchanged() -> Bool {
        return
            editedAccount.credentials.values == account.credentials.values

    }

    private func updateFn() throws {
        account.credentials.update(other: editedAccount.credentials)

        dataContainer.context.insert(account.credentials)

        try dataContainer.context.save()
    }

    private func disableSave() -> Bool {
        return !valid || unchanged()
    }

    var toolbarContent: some ToolbarContent {
        EditingToolbar(
            dismiss: dismissFn,
            unchanged: unchanged,
            update: updateFn,
            disableSaveButton: disableSave
        )
    }

    var validityChecker: some View {
        HStack {
            Text(editedAccount.credentials.name).font(.title)
            ValidityIndicator(emailAccount: $editedAccount)
        }
    }

    var body: some View {
        NavigationStack {
            validityChecker
            Spacer()
            EditCredentialsView(credentials: $editedAccount.credentials)
                .onAppear {
                    editedAccount.credentials.update(other: account.credentials)
                }
                .onChange(of: editedAccount.credentials.values) {
                    validate()
                }
                .toolbar {
                    toolbarContent
                }
        }
        .padding()
    }
}

#Preview {
    EditAccountView(account: EmailAccount.sample)
}
