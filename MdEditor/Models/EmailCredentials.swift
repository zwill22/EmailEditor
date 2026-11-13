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
    var username: String
    var password: String
    var address: Address

    var values: [String] {
        [name, host, "\(port)", username, password, address.address]
    }

    var isEmpty: Bool {
        self.name.isEmpty || self.host.isEmpty || self.username.isEmpty
            || self.password.isEmpty || self.address.isEmpty
    }

    var allEmpty: Bool {
        self.name.isEmpty && self.host.isEmpty && self.username.isEmpty
            && self.password.isEmpty && self.address.isEmpty
    }

    init(
        name: String,
        host: String,
        port: Int,
        username: String,
        password: String,
        address: String
    ) {
        self.name = name
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.address = Address(address: address)
    }
}

extension EmailCredentials {
    static var empty: EmailCredentials {
        .init(
            name: "",
            host: "",
            port: 0,
            username: "",
            password: "",
            address: ""
        )
    }
}
