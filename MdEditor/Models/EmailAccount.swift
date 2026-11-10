//
//  EmailAccount.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import Foundation
import SwiftData

@Model
class EmailAccount {
    var name: String
    var host: String
    var port: Int
    var username: String
    var emailAddress: String
    var password: String

    var itemList: [String] {
        [
            name, host, "\(port)", username, emailAddress, password,
        ]
    }

    var isEmpty: Bool {
        self.name.isEmpty || self.host.isEmpty || self.username.isEmpty
            || self.emailAddress.isEmpty || self.password.isEmpty
    }

    var allEmpty: Bool {
        self.name.isEmpty && self.host.isEmpty && self.username.isEmpty
            && self.emailAddress.isEmpty && self.password.isEmpty
    }

    func isValid() async -> Bool {
        if isEmpty {
            return false
        }

        do {
            let server = try await MailServer(host: host, port: port)

            try await server.login(username: username, password: password)

            try await server.disconnect()

            return true
        } catch {
            return false
        }
    }

    init(
        name: String,
        host: String,
        port: Int,
        username: String,
        emailAddress: String,
        password: String,

    ) {
        self.name = name
        self.host = host
        self.port = port
        self.username = username
        self.emailAddress = emailAddress
        self.password = password
    }
}

extension EmailAccount {
    static var emptyAccount: EmailAccount {
        EmailAccount(
            name: "",
            host: "",
            port: 0,
            username: "",
            emailAddress: "",
            password: ""
        )
    }
}
