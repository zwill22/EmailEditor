//
//  CredentialsView.swift
//  MdEditor
//
//  Created by Zack Williams on 12-11-2026.
//

import SwiftUI

struct CredentialsView: View {
    var credentials: EmailCredentials

    // Display password as 6-12 dots
    func dots() -> Int {
        return min(max(6, credentials.password.count), 12)
    }

    var body: some View {

        Label(" \(credentials.name)", systemImage: "mail.stack").font(
            .title
        )

        Section(header: Text("Host details")) {
            HStack {
                Label("Hostname", systemImage: "server.rack")
                Spacer()
                Text(credentials.host).italic()
            }

            HStack {
                Label("Port", systemImage: "powerplug.portrait")
                Spacer()
                Text("\(credentials.port)").italic()
            }
        }

        Section(header: Text("Account Details")) {
            HStack {
                Label("Email Address", systemImage: "at")
                Spacer()
                Text(credentials.emailAddress.address)
            }

            HStack {
                Label("Password", systemImage: "lock")
                Spacer()
                Text(
                    String(
                        repeating: "\u{2022}",
                        count: dots()
                    )
                )
            }
        }

    }
}

#Preview {
    CredentialsView(credentials: EmailAccount.sample.credentials)
}
