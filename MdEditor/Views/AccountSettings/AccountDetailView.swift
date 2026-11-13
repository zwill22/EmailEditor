//
//  AccountDetailView.swift
//  MdEditor
//
//  Created by Zack Williams on 11-11-2026.
//

import SwiftData
import SwiftUI

struct AccountDetailView: View {
    var account: EmailAccount

    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer

    @State private var showDeleteConfirmation = false

    var confirmDeleteButton: some View {
        Button("Delete account", role: .destructive) {
            dataContainer.context.delete(account.credentials)

            try? dataContainer.context.save()
            dismiss()
        }
    }

    private var deleteButton: some View {
        Button {
            showDeleteConfirmation = true
        } label: {
            Label("Delete", systemImage: "trash")
        }
        .confirmationDialog(
            "Delete account",
            isPresented: $showDeleteConfirmation
        ) {
            confirmDeleteButton
        } message: {
            Text("The account will be permenently deleted")
        }

    }

    var editButton: some View {
        Button {
            //
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }

    var body: some View {
        NavigationStack {
            List {
                CredentialsView(credentials: account.credentials)

                Spacer()

                HStack {
                    deleteButton
                    Spacer()
                    editButton
                }
            }
            .frame(maxWidth: 400)
        }
    }
}

#Preview {
    AccountDetailView(account: EmailAccount.sample)
}
