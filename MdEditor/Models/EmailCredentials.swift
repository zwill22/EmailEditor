//
//  Credentials.swift
//  MdEditor
//
//  Created by Zack Williams on 12-11-2026.
//

import Foundation
import SwiftData

@Model
class EmailCredentials {
    var name: String
    var host: String
    var port: Int
    var emailAddress: Address
    var password: String

    var values: [String] {
        [name, host, "\(port)", password, emailAddress.address]
    }

    var isEmpty: Bool {
        self.name.isEmpty || self.host.isEmpty
            || self.password.isEmpty || self.emailAddress.isEmpty
    }

    var allEmpty: Bool {
        self.name.isEmpty && self.host.isEmpty
            && self.password.isEmpty && self.emailAddress.isEmpty
    }

    init(
        name: String,
        host: String,
        port: Int,
        emailAddress: String,
        password: String
    ) {
        self.name = name
        self.host = host
        self.port = port
        self.emailAddress = Address(address: emailAddress)
        self.password = password
    }
}

extension EmailCredentials {
    static var empty: EmailCredentials {
        .init(
            name: "",
            host: "",
            port: 0,
            emailAddress: "",
            password: "",
        )
    }

    func update(other: EmailCredentials) {
        self.name = other.name
        self.host = other.host
        self.emailAddress =
            Address(address: other.emailAddress.address)
        self.password =
            other.password
        self.port = other.port

        self.name = other.name
    }
}
