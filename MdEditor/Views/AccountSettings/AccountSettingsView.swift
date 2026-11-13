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
    @State private var showNewAccountView: Bool = false

    var mailServer: any MailServer = EMailServer()

    func refresh() {
        self.accounts = credentials.map({ accountCredentials in
            EmailAccount(
                credentials: accountCredentials,
                server: mailServer
            )
        })

        self.selection = nil
    }

    var refreshButton: some View {
        Button {
            refresh()
        } label: {
            Label("Refresh", systemImage: "arrow.clockwise")
        }
    }

    var addButton: some View {
        Button {
            showNewAccountView = true
        } label: {
            Label("Add", systemImage: "plus.circle")
        }
    }

    @ViewBuilder
    var detailView: some View {
        if let account = selection {
            AccountDetailView(account: account)
        } else {
            ContentUnavailableView(
                "No account selected",
                systemImage: "mail.stack"
            )
        }
    }

    var splitView: some View {
        HSplitView {
            VStack {
                AccountListView(
                    accounts: $accounts,
                    selection: $selection,
                )

                HStack {
                    if !accounts.isEmpty {
                        refreshButton.padding()
                    }
                    addButton.padding()
                }
            }

            detailView
                .frame(
                    minWidth: 300,
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .padding(.horizontal)
        }
    }

    var body: some View {
        NavigationStack {
            splitView
                .navigationTitle("Account settings")
        }
        .onAppear {
            refresh()
        }
        .onChange(of: credentials.count) {
            refresh()
        }
        .sheet(isPresented: $showNewAccountView) {
            showNewAccountView = false
            refresh()
        } content: {
            NewAccountView().padding()
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
