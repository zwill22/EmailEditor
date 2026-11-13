//
//  EmailAccount.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import Foundation

class EmailAccount: Identifiable {
    var credentials: EmailCredentials

    private var mailServer: any MailServer

    var isEmpty: Bool {
        self.credentials.isEmpty
    }

    var allEmpty: Bool {
        self.credentials.allEmpty
    }

    func isValid() async -> Bool {
        if isEmpty {
            return false
        }

        do {
            try await mailServer.validate(credentials: credentials)

            return true
        } catch {
            return false
        }
    }

    init(
        credentials: EmailCredentials,
        server: any MailServer
    ) {
        self.credentials = credentials

        self.mailServer = server
    }
}

extension EmailAccount: Hashable {
    static func == (lhs: borrowing EmailAccount, rhs: borrowing EmailAccount)
        -> Bool
    {
        lhs.credentials == rhs.credentials
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(credentials)
    }
}

extension EmailAccount {
    static var emptyAccount: EmailAccount {
        .init(
            credentials: .empty,
            server: EMailServer()
        )
    }

    static var sample = sampleData[0]

    static var sampleData: [EmailAccount] = [
        EmailAccount(
            credentials: .sampleData[0],
            server: PreviewServer.valid
        ),
        EmailAccount(
            credentials: .sampleData[1],
            server: PreviewServer.invalidUser
        ),
        EmailAccount(
            credentials: .sampleData[2],
            server: PreviewServer.invalidServer
        ),
        EmailAccount(
            credentials: .sampleData[3],
            server: PreviewServer.valid
        ),
    ]
}
