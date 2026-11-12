//
//  AccountDetailView.swift
//  MdEditor
//
//  Created by Zack Williams on 11-11-2026.
//

import SwiftUI

struct AccountDetailView: View {
    var account: EmailAccount

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
                CredentialsView(credentials: account.credentials)
                
                Spacer()
                
                HStack {
                    //                cancelButton
                    //                Spacer()
                    deleteButton
                    Spacer()
                    editButton
                }
            }
            .frame(maxWidth: 400)
        }
    }
}

#Preview {
    AccountDetailView(account: EmailAccount.sample)
}
