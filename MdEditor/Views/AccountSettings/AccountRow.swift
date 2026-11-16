//
//  AccountRow.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftUI

struct AccountRow: View {
    @Binding var account: EmailAccount

    @State private var isValid = false
    @State private var isLoading = true

    var body: some View {
        HStack {
            ValidityIndicator(
                emailAccount: $account
            ).padding(.trailing)

            VStack(alignment: .leading) {
                Text(account.credentials.name)
                Text(account.credentials.emailAddress.address).italic()
            }
        }
        .onAppear {
            Task {
                isValid = await account.isValid()
                isLoading = false
            }
        }
    }
}

#Preview {
    AccountRow(account: .constant(EmailAccount.sample))
}
