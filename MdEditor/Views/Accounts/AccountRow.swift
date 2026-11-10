//
//  AccountRow.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftUI

struct AccountRow: View {
    var account: EmailAccount

    @State private var isValid = false
    @State private var isLoading = true

    var body: some View {
        HStack {
            ValidityIndicator(
                valid: $isValid,
                loading: $isLoading
            ).padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text(account.name)
                Text(account.emailAddress).italic()
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                isValid = await account.isValid()
                isLoading = false
            }
        }
        .frame(maxWidth: 400)
    }
}

#Preview {
    AccountRow(account: EmailAccount.sample)
}
