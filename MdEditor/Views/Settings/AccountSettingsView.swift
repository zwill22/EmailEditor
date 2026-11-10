//
//  AccountSettingsView.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftData
import SwiftUI

struct AccountSettingsView: View {
    @Query private var accounts: [EmailAccount]

    @State private var selection: EmailAccount? = nil

    var body: some View {
        NavigationStack {
            if accounts.isEmpty {
                NewAccountView(cancel: false)
            } else {
                List(accounts, id: \.self) { account in
                    AccountRow(account: account)
                }
                .listStyle(.inset)
            }
        }
    }
}

#Preview {
    AccountSettingsView()
        .sampleDataContainer()
}
