//
//  AccountDetailView.swift
//  MdEditor
//
//  Created by Zack Williams on 11-11-2026.
//

import SwiftUI

struct AccountDetailView: View {
//    @Environment(\.dismiss) private var dismiss

    var account: EmailAccount

    @State private var valid = false
    @State private var loading = false

//    var cancelButton: some View {
//        Button {
//            dismiss()
//        } label: {
//            Label("Cancel", systemImage: "x.circle")
//        }
//    }

    var deleteButton: some View {
        Button {
            //
        } label: {
            Label("Delete", systemImage: "trash")
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
                HStack {
                    Label(" \(account.name)", systemImage: "mail.stack").font(
                        .title
                    )
                    Spacer()
                    ValidityIndicator(
                        valid: $valid,
                        loading: $loading,
                        size: 24,
                        fontSize: .title2
                    )
                }
                Section(header: Text("Host details")) {
                    HStack {
                        Label("Hostname", systemImage: "server.rack")
                        Spacer()
                        Text(account.host).italic()
                    }
                    
                    HStack {
                        Label("Port", systemImage: "powerplug.portrait")
                        Spacer()
                        Text("\(account.port)").italic()
                    }
                }
                
                Section(header: Text("Account Details")) {
                    HStack {
                        Label("Username", systemImage: "person")
                        Spacer()
                        Text(account.username)
                    }
                    
                    HStack {
                        Label("Email Address", systemImage: "at")
                        Spacer()
                        Text(account.emailAddress)
                    }
                    
                    HStack {
                        Label("Password", systemImage: "lock")
                        Spacer()
                        Text(
                            String(
                                repeating: "\u{2022}",
                                count: min(account.password.count, 12)
                            )
                        )
                    }
                }
                
                Spacer()
                
                HStack {
                    //                cancelButton
                    //                Spacer()
                    deleteButton
                    Spacer()
                    editButton
                }
            }
            .navigationTitle("Details: \(account.name)")
        }
        .frame(maxWidth: 400)
    }
}

#Preview {
    AccountDetailView(account: EmailAccount.sample)
}
