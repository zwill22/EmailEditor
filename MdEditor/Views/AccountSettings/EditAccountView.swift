//
//  EditCredentialsView.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftUI

struct EditCredentialsView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var credentials: EmailCredentials

    let portFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumIntegerDigits = 3
        formatter.maximumIntegerDigits = 3
        return formatter
    }()

    var body: some View {
        Form {
            TextField("Name", text: $credentials.name)
            LabeledContent("Host") {
                HStack {
                    TextField("Host", text: $credentials.host)

                    Text("Port")
                    TextField(
                        "Port",
                        value: $credentials.port,
                        formatter: portFormatter
                    ).frame(maxWidth: 50)
                }.labelsHidden()
            }
            TextField("Username", text: $credentials.username)
            TextField(
                "Email Address",
                text: $credentials.address.address,
            )
            SecureField("Password", text: $credentials.password)
        }
        .padding(.vertical)
    }
}

#Preview {
    EditCredentialsView(credentials: .constant(.sample))
}
