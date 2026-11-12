//
//  AddAccountView.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftUI

struct AccountEditView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var emailAccount: EmailAccount

    let portFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumIntegerDigits = 3
        formatter.maximumIntegerDigits = 3
        return formatter
    }()

    var body: some View {
        Form {
            TextField("Name", text: $emailAccount.name)
            LabeledContent("Host") {
                HStack {
                    TextField("Host", text: $emailAccount.host)

                    Text("Port")
                    TextField(
                        "Port",
                        value: $emailAccount.port,
                        formatter: portFormatter
                    ).frame(maxWidth: 50)
                }.labelsHidden()
            }
            TextField("Username", text: $emailAccount.username)
            TextField(
                "Email Address",
                text: $emailAccount.emailAddress,
            )
            SecureField("Password", text: $emailAccount.password)
        }
        .padding(.vertical)
    }
}

#Preview {
    AccountEditView(emailAccount: .constant(.sample))
}
