//
//  AccountListView.swift
//  MdEditor
//
//  Created by Zack Williams on 11-11-2026.
//

import SwiftUI

struct AccountListView: View {
    @Binding var accounts: [EmailAccount]
    @Binding var selection: EmailAccount?

    @ContentBuilder
    private var overlayContent: some View {
        if accounts.isEmpty {
            ContentUnavailableView(
                "No Email Accounts",
                systemImage: "exclamationmark.circle.fill"
            )
        }
    }

    var body: some View {
        NavigationStack {
            List($accounts, id: \.self, selection: $selection) {
                account in
                AccountRow(account: account)
            }
            .frame(minWidth: 240, maxHeight: .infinity)
            .overlay {
                overlayContent
            }
        }
    }
}

#Preview {
    AccountListView(
        accounts: .constant(EmailAccount.sampleData),
        selection: .constant(nil)
    )
}
