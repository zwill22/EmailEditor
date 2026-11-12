//
//  AccountSettingsView.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftData
import SwiftUI

struct AccountSettingsView: View {
    @Query private var credentials: [EmailCredentials]

    @State private var accounts: [EmailAccount] = []
    @State private var selection: EmailAccount? = nil

    var mailServer: any MailServer = EMailServer()

    var body: some View {
        NavigationStack {
            HSplitView {
                AccountListView(accounts: $accounts, selection: $selection)

                VStack {
                    if let account = selection {
                        AccountDetailView(account: account)
                    } else {
                        Text("Empty")
                    }
                }
                .frame(minWidth: 300, maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)
            }
            .navigationTitle("Account settings")
        }
        .onAppear {
            self.accounts = credentials.map({ accountCredentials in
                EmailAccount(
                    credentials: accountCredentials,
                    server: mailServer
                )
            })
        }
    }
}

#Preview {
    AccountSettingsView(mailServer: PreviewServer.valid)
        .sampleDataContainer()
}

#Preview("No accounts") {
    AccountSettingsView()
}
