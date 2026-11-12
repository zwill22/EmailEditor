//
//  NewAccountView.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftData
import SwiftUI

struct NewAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    @State private var newAccount: EmailAccount = .emptyAccount

    @State private var error: EditorError?
    @State private var hasError = false

    @State private var valid = false
    @State private var checkingValidity = false

    var cancel = true

    private func validate() {
        self.checkingValidity = true
        Task {
            if newAccount.isEmpty {
                self.valid = false
            } else {
                self.valid = await newAccount.isValid()
            }
        }

        self.checkingValidity = false
    }

    var resetButton: some View {
        Button("Reset", systemImage: "arrow.counterclockwise") {
            self.newAccount = .emptyAccount
        }
        .disabled(newAccount.allEmpty)
    }

    var cancelButton: some View {
        Button("Cancel", systemImage: "x.circle") {
            // Dismiss
            dismiss()
        }
    }

    var addButton: some View {
        Button("Add", systemImage: "checkmark") {
            dataContainer.context.insert(newAccount.credentials)

            do {
                try dataContainer.context.save()
                if cancel {
                    dismiss()
                }
            } catch {
                // Don't dismiss
            }
        }
        .buttonStyle(.glass)
        .disabled(!valid)
    }

    var newAccountMenu: some View {
        HStack {
            resetButton
            Spacer()

            Text(valid ? "Valid" : "Invalid")
            ValidityIndicator(
                emailAccount: $newAccount,
                size: 24,
                fontSize: .title2
            )
            if cancel {
                cancelButton
            }
            addButton
        }
    }

    var body: some View {
        VStack {
            EditCredentialsView(credentials: $newAccount.credentials)
                .onChange(of: newAccount.credentials.hashValue) {
                    validate()
                }

            newAccountMenu
        }
        .alert(isPresented: $hasError, error: error) {}
    }
}

#Preview {
    NewAccountView().sampleDataContainer()
}

#Preview("Without cancel button") {
    NewAccountView(cancel: false).sampleDataContainer()
}
